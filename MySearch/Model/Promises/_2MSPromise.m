//
//  MSPromise.m
//  MySearch
//
//  Created by Alexander Sviridov on 30/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "_2MSPromise.h"

#import "NSArray+MSLinqExtension.h"

@interface _2MSPromise ()

@property BOOL pending;
@property NSError *rejectedValue;
@property id fullfilledValue;
@property NSMutableArray<_2MSPromise *> *listengers;
@property (copy) MSPromiseDisposable (^startingBlock)(MSPromiseFullfillBlock,MSPromiseRejectBclock, id, NSError*);

@end

@implementation _2MSPromise
{
    MSPromiseDisposable _disposable;
}

- (instancetype)initWithBlock:(MSPromiseDisposable (^)(MSPromiseFullfillBlock, MSPromiseRejectBclock, id, NSError*))block
{
    self = [self init];
    if ( self )
    {
        __weak _2MSPromise *weakSelf = self;
        _startingBlock = _startingBlock;
//        _disposable = block(^(id nextValue){
//            [weakSelf.listengers enumerateObjectsUsingBlock:^(MSPromise * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [obj _prevPromiseHasDone:nextValue reject:nil];
//            }];
//        }, ^(NSError *rejectValue){
//            [weakSelf.listengers enumerateObjectsUsingBlock:^(MSPromise * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [obj _prevPromiseHasDone:nil reject:rejectValue];
//            }];
//        });
    }
    return self;
}

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
    return [[self alloc] initWithBlock:^MSPromiseDisposable(MSPromiseFullfillBlock fullfilBlock, MSPromiseRejectBclock rejectBlock, id prevValue, NSError *prevReject) {
        return block(fullfilBlock,rejectBlock);
    }];
}

- (_2MSPromise *)then:(_2MSPromise *(^)(id))block
{
    _2MSPromise *newPromise = [[_2MSPromise alloc] initWithBlock:^MSPromiseDisposable(MSPromiseFullfillBlock fullfilBlock, MSPromiseRejectBclock rejectBlock, id prevValue, NSError *prevReject) {
        if ( prevValue )
        {
            _2MSPromise *nextPromise = block(prevValue);
            
            return nil;
        }
        rejectBlock(prevReject);
        return nil;
    }];
    [self.listengers addObject:newPromise];
    return nil;
}

- (void)resolve:(id)nextValue
{
    
}

- (void)reject:(NSError *)error
{
    
}

- (void)onPrev:(id)prevValue
{
    
}

- (void)onPrevReject:(NSError *)prevError
{
    
}

#pragma mark - private

- (void)_prevPromiseHasDone:(id)nextValue reject:(NSError *)rejectedValue
{
    
}

@end
