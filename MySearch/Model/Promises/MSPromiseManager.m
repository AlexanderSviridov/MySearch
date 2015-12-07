//
//  MSPromiseManager.m
//  MySearch
//
//  Created by Alexander Sviridov on 07/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSPromiseManager.h"

#import "MSWeakSet.h"
#import "MSPromise.h"

@implementation MSPromiseManager
{
    MSWeakSet *_weakSet;
}

+ (instancetype)sharedManager
{
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [self new];
    });
    return singleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _weakSet = [MSWeakSet new];
    }
    return self;
}

- (void)addPromiseToObserve:(MSPromise *)promise
{
    [_weakSet addObject:promise];
}

- (void)printListOfCurrentPromises
{
    NSArray *promises = [_weakSet currentArray];
    __block NSString *string = [NSString stringWithFormat:@"--- Count:%d", (int)promises.count ];
    [promises enumerateObjectsUsingBlock:^(MSPromise  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        string = [string stringByAppendingFormat:@"\n%@", obj.debugName ];
    }];
    NSLog(@"%@", string);
}

@end

