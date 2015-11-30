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

@interface _MSPromise : NSObject
{
    MSPromiseRejectBclock  _reject;
    MSPromiseFullfillBlock _fullfil;
}

+ (_MSPromise *)newPromise:(MSPromiseDisposable(^)(MSPromiseFullfillBlock,MSPromiseRejectBclock))block;

- (_MSPromise *)then:(MSPromiseNextBlock)thenBlock;
- (_MSPromise *)thenOnBackground:(MSPromiseNextBlock)thenBlock;

- (void)cancel;

@end
