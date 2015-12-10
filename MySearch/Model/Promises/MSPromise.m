//
//  MSPromise.m
//  MySearch
//
//  Created by Alexander Sviridov on 30/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSPromise.h"

#import "NSArray+MSLinqExtension.h"
#import "NSString+MSRegex.h"
#import "MSPromiseManager.h"

@interface MSPromiseListengerContainer : NSObject

@property MSPromise *promise;
@property (copy) void(^onCompleate)(id, NSError *, MSPromise *);

@end

@implementation MSPromiseListengerContainer

+ (instancetype)listengerWithPromise:(MSPromise *)promise compleationBlock:(void(^)(id, NSError *, MSPromise *))compleation
{
    MSPromiseListengerContainer *container = [MSPromiseListengerContainer new];
    container.promise = promise;
    container.onCompleate = compleation;
    return container;
}

@end

@interface MSPromise ()

@property NSMutableArray<MSPromiseListengerContainer *> *listengers;
@property id compleatedValue;
@property NSError *compleatedError;
@property (weak) MSPromise *prevPromise;
@property (copy) MSPromiseDisposable disposableBlock;

@end

@implementation MSPromise

- (instancetype)init
{
    self = [super init];
    if ( self )
    {
        _listengers = [NSMutableArray new];
        [MSPromiseManager.sharedManager addPromiseToObserve:self];
    }
    return self;
}

+ (instancetype)newPromise:(MSPromiseDisposable (^)(MSPromiseFullfillBlock, MSPromiseRejectBclock))block
{
    MSPromise *resultPromise = [MSPromise new];
    resultPromise.debugName = [self callStackName:0];
    resultPromise.disposableBlock = block(^(id fullfil){
        [resultPromise onValue:fullfil error:nil];
    }, ^(NSError *reject){
        [resultPromise onValue:nil error:reject];
    });
    
    return resultPromise;
}

+ (NSString *)callStackName:(NSInteger)stackIndex
{
    return [(NSString *)[NSThread callStackSymbols][stackIndex + 2] stringByRemovingRegex:@".+0x[0-9a-f]+\\s"];
}

+ (instancetype)promiseWithValue:(id)value
{
    MSPromise *promise = [self newPromise:^MSPromiseDisposable(MSPromiseFullfillBlock fullfil, MSPromiseRejectBclock reject) {
        fullfil( value );
        return ^{
        };
    }];
    promise.debugName = [NSString stringWithFormat:@"%@ Value[%@]:%@", [self callStackName:0], NSStringFromClass([value class]), value];
    return promise;
}

+ (instancetype)promiseWithError:(NSError *)error
{
    MSPromise *promise = [self newPromise:^MSPromiseDisposable(MSPromiseFullfillBlock fullfil, MSPromiseRejectBclock reject) {
        reject(error);
        return ^{
        };
    }];
    promise.debugName = [NSString stringWithFormat:@"%@ Error[%@]:%@", [self callStackName:0], NSStringFromClass([error class]), error];
    return promise;
}

- (id)then:(MSPromise *(^)(id))thenBlock
{
    return [self then:thenBlock onQueue:dispatch_get_main_queue()];
}

- (id)thenOnBackground:(MSPromise *(^)(id))thenBlock
{
    return [self then:thenBlock onQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}

- (id)then:(MSPromise *(^)(id))thenBlock onQueue:(dispatch_queue_t)queue
{
    MSPromise *newPromise = [MSPromise new];
    newPromise.debugName = [self.debugName stringByAppendingFormat:@"then%@ ", [MSPromise callStackName:1] ];
    [self addListengerWithPromise:newPromise onCompleation:^(id next, NSError *error, MSPromise *owner) {
        if ( !error ) {
            dispatch_async(queue, ^{
                MSPromise *nextPromise = thenBlock(next);
                if ( !nextPromise )
                    [owner onValue:next error:nil];
                else if ( [nextPromise isKindOfClass:[MSPromise class]] ) {
                    owner.debugName = [owner.debugName stringByAppendingFormat:@"(promise:%@)", nextPromise.debugName ];
                    [nextPromise addListengerWithPromise:owner onCompleation:^(id next, NSError *error, MSPromise *owner) {
                        [owner onValue:next error:error];
                    }];
                }
                else if ( [nextPromise isKindOfClass:[NSError class]] )
                    [owner onValue:nil error:(NSError *)nextPromise];
                else
                    [owner onValue:nextPromise error:nil];
            });
            return;
        }
        else
            [owner onValue:nil error:error];
    }];
    return newPromise;
}

- (id)catch:(MSPromise *(^)(NSError *))rejectErrorBlock
{
    MSPromise *newPromise = [MSPromise new];
    newPromise.debugName = [self.debugName stringByAppendingFormat:@"catch%@ ", [MSPromise callStackName:1] ];
    [self addListengerWithPromise:newPromise onCompleation:^(id next, NSError *error, MSPromise *owner) {
        if ( error ) {
            dispatch_async(dispatch_get_main_queue(), ^{
                MSPromise *nextPromise = rejectErrorBlock(error);
                if ( !nextPromise )
                    [owner onValue:nil error:error];
                else if ( [nextPromise isKindOfClass:[MSPromise class]] ) {
                    owner.debugName = [owner.debugName stringByAppendingFormat:@"(promise%@)", nextPromise.debugName ];
                    [nextPromise addListengerWithPromise:owner onCompleation:^(id next, NSError *error, MSPromise *owner) {
                        [owner onValue:next error:error];
                    }];
                }
                else if ( [nextPromise isKindOfClass:[NSError class]] )
                    [owner onValue:nil error:(NSError *)nextPromise];
                else
                    [owner onValue:nextPromise error:nil];
            });
        }
        else
            [owner onValue:next error:nil];
    }];
    return newPromise;
}

- (id)once
{
    if ( self.isCompleated )
        return self.compleatedError ? [MSPromise promiseWithError:self.compleatedError] : [MSPromise promiseWithValue:self.compleatedValue];
    
    return [MSPromise newPromise:^MSPromiseDisposable(MSPromiseFullfillBlock fulfil, MSPromiseRejectBclock reject) {
        __weak MSPromise *promise = [[self then:^MSPromise *(id result) {
            fulfil( result );
            return nil;
        }] catch:^MSPromise *(NSError *error) {
            reject( error );
            return nil;
        }];
        return ^{
            if ( promise ) [promise dispose];
        };
    }];
}

- (void)dispose
{
    @synchronized(self) {
//        if ( self.isCompleated )
//            return;
        if ( self.prevPromise )
            [self.prevPromise removeListenerWithPromise:self];
        if ( self.disposableBlock )
            self.disposableBlock();
    };
}

#pragma mark - private

- (void)cleanInvalidListengers
{
    self.listengers = [self.listengers linq_map:^id(MSPromiseListengerContainer *container) {
        if ( !container.promise )
        {
            container.onCompleate = nil;
            return nil;
        }
        return container;
    }];
}

- (void)addListengerWithPromise:(MSPromise *)promise onCompleation:(void(^)(id, NSError *, MSPromise *))compleationBlock
{
    @synchronized( self ) {
        if ( promise.prevPromise ) [promise.prevPromise removeListenerWithPromise:self];
        promise.prevPromise = self;
        if ( self.isCompleated )
            compleationBlock(self.compleatedValue, self.compleatedError, promise);
        [self.listengers addObject:[MSPromiseListengerContainer listengerWithPromise:promise compleationBlock:compleationBlock]];
    }
}

- (void)removeListenerWithPromise:(MSPromise *)promise
{
    @synchronized( self ) {
        [self cleanInvalidListengers];
        self.listengers = [self.listengers linq_map:^id(MSPromiseListengerContainer *object) {
            return ( object.promise == promise ) ? nil : object;
        }];
        if ( !self.listengers.count )
            [self dispose];
    }
}

- (void)onValue:(id)prevValue error:(NSError *)error
{
    _isCompleated = YES;
    self.compleatedError = error;
    self.compleatedValue = prevValue;
    [self cleanInvalidListengers];
    self.debugName = [self.debugName stringByAppendingFormat:@"(%s:[%@])", error? "error": prevValue ? "value" : "nil", NSStringFromClass(error?[error class]: [prevValue class]) ];
    [self.listengers enumerateObjectsUsingBlock:^(MSPromiseListengerContainer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ( error )
            obj.onCompleate(nil, error, obj.promise );
        if ( prevValue )
            obj.onCompleate(prevValue,nil, obj.promise );
    }];
}

- (void)dealloc
{
//    if ( [@"tag" isEqualToString:self.debugName] )
//        NSLog(@"");
//    NSLog(@"%s %@", __PRETTY_FUNCTION__, self.debugName );
    if ( self.prevPromise )
        [self.prevPromise removeListenerWithPromise:self];
}

@end

