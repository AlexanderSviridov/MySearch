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

@property (readonly) BOOL isCompleated;
@property (copy) NSString *debugName;

+ (instancetype)newPromise:(MSPromiseDisposable(^)(MSPromiseFullfillBlock,MSPromiseRejectBclock))block;
+ (instancetype)promiseWithValue:(id)value;
+ (instancetype)promiseWithError:(NSError *)error;

- (id)then:(MSPromise *(^)(ObjectType))thenBlock;
- (id)thenOnBackground:(MSPromise *(^)(ObjectType))thenBlock;
- (id)then:(MSPromise *(^)(ObjectType))thenBlock onQueue:(dispatch_queue_t)queue;

- (id)catch:(MSPromise *(^)(NSError *))rejectErrorBlock;

- (id)once;

- (void)dispose;

@end
