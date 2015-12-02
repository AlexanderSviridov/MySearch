//
//  MSiTunesAppSearchRequestContainer.m
//  MySearch
//
//  Created by Alexander Sviridov on 02/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSiTunesAppSearchRequestContainer.h"

@implementation MSiTunesAppSearchRequestContainer

+ (NSDictionary<NSString *, NSString *> *)msSerializationMapping
{
    return @{
        @"term":@"term",
        @"country":@"country",
        @"media":@"media",
        @"entity":@"entity",
        @"attribute":@"attribute",
        @"callback":@"callback",
        @"limit":@"limit",
        @"lang":@"lang",
        @"version":@"version",
        @"requestExplicit":@"explicit"
    };
}

+ (NSValueTransformer *)msSerializationTransformerForKey:(NSString *)key
{
    return nil;
}

@end
