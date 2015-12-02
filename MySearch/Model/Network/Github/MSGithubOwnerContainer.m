//
//  MSGithubOwnerContainer.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSGithubOwnerContainer.h"

@implementation MSGithubOwnerContainer

+ (NSDictionary<NSString *,NSString *> *)msSerializationMapping
{
    return @{
        @"login":@"login",
        @"container_id":@"id",
        @"avatar_url":@"avatar_url",
        @"gravatar_id":@"gravatar_id",
        @"url":@"url",
        @"html_url":@"html_url",
        @"followers_url":@"followers_url",
        @"following_url":@"following_url",
        @"gists_url":@"gists_url",
        @"starred_url":@"starred_url",
        @"subscriptions_url":@"subscriptions_url",
        @"organizations_url":@"organizations_url",
        @"repos_url":@"repos_url",
        @"events_url":@"events_url",
        @"received_events_url":@"received_events_url",
        @"type":@"type",
        @"site_admin":@"site_admin"
    };
}

+ (NSValueTransformer *)msSerializationTransformerForKey:(NSString *)key
{
    return nil;
}

@end
