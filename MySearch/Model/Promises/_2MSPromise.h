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

@interface _2MSPromise : NSObject

+ (instancetype)newPromise:(MSPromiseDisposable(^)(MSPromiseFullfillBlock, MSPromiseRejectBclock))block;

- (_2MSPromise *)then:(_2MSPromise *(^)(id nextValue))block;

@end
