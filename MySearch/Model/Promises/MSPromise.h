//
//  MSPromise.h
//  MySearch
//
//  Created by Alexander Sviridov on 30/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MSPromiseFullfillBlock)(id);
typedef void(^MSPromiseRejectBclock)(NSError *);
typedef void(^MSPromiseDisposable)();
typedef id(^MSPromiseNextBlock)(id);

@interface MSPromise : NSObject
{
    MSPromiseRejectBclock  _reject;
    MSPromiseFullfillBlock _fullfil;
}

+ (MSPromise *)newPromise:(MSPromiseDisposable(^)(MSPromiseFullfillBlock,MSPromiseRejectBclock))block;

- (MSPromise *)then:(MSPromiseNextBlock)thenBlock;
- (MSPromise *)thenOnBackground:(MSPromiseNextBlock)thenBlock;

- (void)cancel;

@end
