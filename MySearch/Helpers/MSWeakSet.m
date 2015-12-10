//
//  MSWeakArray.m
//  MySearch
//
//  Created by Alexander Sviridov on 07/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSWeakSet.h"

#import "NSArray+MSLinqExtension.h"

@interface MSWeakSetContainer : NSObject

@property (weak) id object;

@end

@implementation MSWeakSetContainer

+ (instancetype)containerWithObject:(id)object
{
    MSWeakSetContainer *container = [MSWeakSetContainer new];
    container.object = object;
    return container;
}

@end

@implementation MSWeakSet
{
    NSMutableArray<MSWeakSetContainer *> *_array;
}

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        _array = [NSMutableArray new];
    }
    return self;
}

- (void)addObject:(id)object
{
    [_array addObject:[MSWeakSetContainer containerWithObject:object]];
}

- (void)removeInvalidObjects
{
    _array = [_array linq_map:^id(MSWeakSetContainer *container) {
        return container.object ? container : nil;
    }];
}

- (NSArray *)currentArray
{
    [self removeInvalidObjects];
    return [_array linq_map:^id(MSWeakSetContainer *container) {
        return container.object;
    }];
    
}

@end
