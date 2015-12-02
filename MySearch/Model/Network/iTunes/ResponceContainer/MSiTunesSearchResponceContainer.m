//
//  MSiTunesSearchResponceContainer.m
//  MySearch
//
//  Created by Alexander Sviridov on 02/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSiTunesSearchResponceContainer.h"

#import "MSSerializationValueTransformer.h"
#import "MSiTunesSearchResponceEntityContainer.h"

@implementation MSiTunesSearchResponceContainer

+ (NSDictionary<NSString *, NSString *> *)msSerializationMapping
{
    return @{
        @"resultCount":@"resultCount",
        @"results":@"results",
    };
}

+ (NSValueTransformer *)msSerializationTransformerForKey:(NSString *)key
{
    if ( [@"results" isEqualToString:key] )
    {
        return [MSSerializationValueTransformer transformerForArraySerializedObjectsOfClass:[MSiTunesSearchResponceEntityContainer class]];
    }
    return nil;}

@end
