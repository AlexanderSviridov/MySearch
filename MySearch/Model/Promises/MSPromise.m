//
//  MSPromise.m
//  MySearch
//
//  Created by Alexander Sviridov on 30/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSPromise.h"

@interface MSPromise ()

@property NSMutableArray<MSPromise *> *listengers;

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

#pragma mark - private

- (void)onValue:(id)prevValue
{
    
    [_listengers enumerateObjectsUsingBlock:^(MSPromise * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    }];
}

@end

