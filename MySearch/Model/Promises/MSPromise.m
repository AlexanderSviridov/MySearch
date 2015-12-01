//
//  MSPromise.m
//  MySearch
//
//  Created by Alexander Sviridov on 30/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSPromise.h"

#import "NSArray+MSLinqExtension.h"

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
@property BOOL isCompleated;
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
    }
    return self;
}

+ (instancetype)newPromise:(MSPromiseDisposable (^)(MSPromiseFullfillBlock, MSPromiseRejectBclock))block
{
    MSPromise *resultPromise = [MSPromise new];
    resultPromise.disposableBlock = block(^(id fullfil){
        [resultPromise onValue:fullfil error:nil];
    }, ^(NSError *reject){
        [resultPromise onValue:nil error:reject];
    });
    
    return resultPromise;
}

+ (instancetype)promiseWithValue:(id)value
{
    return [self newPromise:^MSPromiseDisposable(MSPromiseFullfillBlock fullfil, MSPromiseRejectBclock reject) {
        fullfil( value );
        return ^{
        };
    }];
}

+ (instancetype)promiseWithError:(NSError *)error
{
    return [self newPromise:^MSPromiseDisposable(MSPromiseFullfillBlock fullfil, MSPromiseRejectBclock reject) {
        reject(error);
        return ^{
        };
    }];
}

- (instancetype)then:(MSPromise *(^)(id))thenBlock
{
    return [self then:thenBlock onQueue:dispatch_get_main_queue()];
}

- (instancetype)thenOnBackground:(MSPromise *(^)(id))thenBlock
{
    return [self then:thenBlock onQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}

- (instancetype)then:(MSPromise *(^)(id))thenBlock onQueue:(dispatch_queue_t)queue
{
    MSPromise *newPromise = [MSPromise new];
    [self addListengerWithPromise:newPromise onCompleation:^(id next, NSError *error, MSPromise *owner) {
        if ( !error )
        {
            dispatch_async(queue, ^{
                MSPromise *nextPromise = thenBlock(next);
                if ( !nextPromise )
                    [owner onValue:next error:nil];
                else
                    [nextPromise addListengerWithPromise:newPromise onCompleation:^(id next, NSError *error, MSPromise *owner) {
                        [owner onValue:next error:error];
                    }];
            });
            return;
        }
        else
            [owner onValue:nil error:error];
    }];
    return newPromise;
}

- (MSPromise *)catch:(MSPromise *(^)(NSError *))rejectErrorBlock
{
    MSPromise *newPromise = [MSPromise new];
    [self addListengerWithPromise:newPromise onCompleation:^(id next, NSError *error, MSPromise *owner) {
        if ( error )
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                MSPromise *nextPromise = rejectErrorBlock(error);
                if ( !newPromise )
                    [owner onValue:nil error:error];
                else
                    [nextPromise addListengerWithPromise:owner onCompleation:^(id next, NSError *error, MSPromise *owner) {
                        [owner onValue:next error:error];
                    }];
            });
        }
        else
            [owner onValue:next error:nil];
    }];
    return newPromise;
}

- (void)dispose
{
    @synchronized(self) {
        if ( self.isCompleated )
            return;
        if ( self.prevPromise )
            [self.prevPromise removeListenerWithPromise:self];
        if ( self.disposableBlock )
            self.disposableBlock();
    };
}

#pragma mark - private

- (void)addListengerWithPromise:(MSPromise *)promise onCompleation:(void(^)(id, NSError *, MSPromise *))compleationBlock
{
    @synchronized( self )
    {
        promise.prevPromise = self;
        if ( self.isCompleated )
            compleationBlock(self.compleatedValue, self.compleatedError, promise);
        [self.listengers addObject:[MSPromiseListengerContainer listengerWithPromise:promise compleationBlock:compleationBlock]];
    }
}

- (void)removeListenerWithPromise:(MSPromise *)promise
{
    @synchronized( self )
    {
        self.listengers = [self.listengers linq_map:^id(MSPromiseListengerContainer *object) {
            return ( object.promise == promise ) ? nil : object;
        }];
        if ( !self.listengers.count )
            [self dispose];
    }
}

- (void)onValue:(id)prevValue error:(NSError *)error
{
    self.isCompleated = YES;
    self.compleatedError = error;
    self.compleatedValue = prevValue;
    [self.listengers enumerateObjectsUsingBlock:^(MSPromiseListengerContainer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ( !error )
            obj.onCompleate(prevValue,nil, obj.promise );
        else
            obj.onCompleate(nil, error, obj.promise );
    }];
}

@end

