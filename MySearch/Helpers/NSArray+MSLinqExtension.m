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
    return [NSArray arrayWithArray:arr];
}

@end
