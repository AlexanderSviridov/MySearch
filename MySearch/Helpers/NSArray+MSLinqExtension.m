//
//  NSArray+MSLinqExtension.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "NSArray+MSLinqExtension.h"

@implementation NSArray (MSLinqExtension)

- (instancetype)linq_map:(id (^)(id))mappingBlock
{
    if ( !mappingBlock )
        return nil;
    NSMutableArray *arr = [NSMutableArray new];
    for ( id item in self )
    {
        id newItem = mappingBlock(item);
        if ( newItem )
            [arr addObject:newItem];
    }
    if ( [self isKindOfClass:[NSMutableArray class]] )
        return arr;
    return [NSArray arrayWithArray:arr];
}

+ (NSArray *)arrayWithBlock:(id (^)(NSInteger))block count:(NSInteger)count
{
    if ( count < 0 )
        return nil;
    if ( !block )
        return nil;
    NSMutableArray *arr = [NSMutableArray new];
    for ( NSInteger i = 0; i < count; ++i )
    {
        id item = block( i );
        if ( item )
        {
            [arr addObject:item];
        }
    }
    return [NSArray arrayWithArray:arr];
}

@end
