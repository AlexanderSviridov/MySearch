//
//  MSPromise.h
//  MySearch
//
//  Created by Alexander Sviridov on 30/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSPromise;

typedef void(^MSPromiseFullfillBlock)(id);
typedef void(^MSPromiseRejectBclock)(NSError *);
typedef void(^MSPromiseDisposable)();

@interface MSPromise<__covariant ObjectType> : NSObject

+ (instancetype)newPromise:(MSPromiseDisposable(^)(MSPromiseFullfillBlock,MSPromiseRejectBclock))block;
+ (instancetype)promiseWithValue:(id)value;
+ (instancetype)promiseWithError:(NSError *)error;

- (MSPromise *)then:(MSPromise *(^)(ObjectType))thenBlock;
- (MSPromise *)thenOnBackground:(MSPromise *(^)(ObjectType))thenBlock;
- (MSPromise *)then:(MSPromise *(^)(ObjectType))thenBlock onQueue:(dispatch_queue_t)queue;

- (MSPromise *)catch:(MSPromise *(^)(NSError *))rejectErrorBlock;

- (void)dispose;

@end
