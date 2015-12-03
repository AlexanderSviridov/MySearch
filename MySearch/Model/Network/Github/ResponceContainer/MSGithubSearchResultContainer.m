//
//  MSGithubSearchResultContainer.m
//  MySearch
//
//  Created by Alexander Sviridov on 03/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSGithubSearchResultContainer.h"

#import "MSSerializationValueTransformer.h"
#import "MSGithubSearchResultEntryContainer.h"

@implementation MSGithubSearchResultContainer

+ (NSDictionary<NSString *,NSString *> *)msSerializationMapping
{
    return @{
        @"totalCount":@"total_count",
        @"incompleteResults":@"incomplete_results",
        @"items":@"items"
    };
}

+ (NSValueTransformer *)msSerializationTransformerForKey:(NSString *)key
{
    if ( [key isEqualToString:@"items"] )
        return [MSSerializationValueTransformer transformerForArraySerializedObjectsOfClass:[MSGithubSearchResultEntryContainer class]];
    return nil;
}

- (BOOL)isIncompleteResult
{
    return self.incompleteResults;
}

- (NSArray<id<MSSearchResultCellViewModel>> *)cellArray
{
    return self.items;
}

@end
