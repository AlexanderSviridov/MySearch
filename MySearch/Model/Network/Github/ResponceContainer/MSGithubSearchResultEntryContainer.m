//
//  MSGithubSearchResultContainer.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSGithubSearchResultEntryContainer.h"

#import "MSGithubOwnerContainer.h"

#import "MSSerializationValueTransformer.h"

@implementation MSGithubSearchResultEntryContainer

#pragma mark - serialization

+ (NSDictionary<NSString *,NSString *> *)msSerializationMapping
{
    return @{
        @"container_id":@"id",
        @"name":@"name",
        @"full_name":@"full_name",
        @"owner":@"owner",
        @"container_private":@"private",
        @"html_url":@"html_url",
        @"container_description":@"description",
        @"fork":@"fork",
        @"url":@"url",
        @"forks_url":@"forks_url",
        @"keys_url":@"keys_url",
        @"collaborators_url":@"collaborators_url",
        @"teams_url":@"teams_url",
        @"hooks_url":@"hooks_url",
        @"issue_events_url":@"issue_events_url",
        @"events_url":@"events_url",
        @"assignees_url":@"assignees_url",
        @"branches_url":@"branches_url",
        @"tags_url":@"tags_url",
        @"blobs_url":@"blobs_url",
        @"git_tags_url":@"git_tags_url",
        @"git_refs_url":@"git_refs_url",
        @"trees_url":@"trees_url",
        @"statuses_url":@"statuses_url",
        @"languages_url":@"languages_url",
        @"stargazers_url":@"stargazers_url",
        @"contributors_url":@"contributors_url",
        @"subscribers_url":@"subscribers_url",
        @"subscription_url":@"subscription_url",
        @"commits_url":@"commits_url",
        @"git_commits_url":@"git_commits_url",
        @"comments_url":@"comments_url",
        @"issue_comment_url":@"issue_comment_url",
        @"contents_url":@"contents_url",
        @"compare_url":@"compare_url",
        @"merges_url":@"merges_url",
        @"archive_url":@"archive_url",
        @"downloads_url":@"downloads_url",
        @"issues_url":@"issues_url",
        @"pulls_url":@"pulls_url",
        @"milestones_url":@"milestones_url",
        @"notifications_url":@"notifications_url",
        @"labels_url":@"labels_url",
        @"releases_url":@"releases_url",
        @"created_at":@"created_at",
        @"updated_at":@"updated_at",
        @"pushed_at":@"pushed_at",
        @"git_url":@"git_url",
        @"ssh_url":@"ssh_url",
        @"clone_url":@"clone_url",
        @"svn_url":@"svn_url",
        @"homepage":@"homepage",
        @"size":@"size",
        @"stargazers_count":@"stargazers_count",
        @"watchers_count":@"watchers_count",
        @"language":@"language",
        @"has_issues":@"has_issues",
        @"has_downloads":@"has_downloads",
        @"has_wiki":@"has_wiki",
        @"has_pages":@"has_pages",
        @"forks_count":@"forks_count",
        @"mirror_url":@"mirror_url",
        @"open_issues_count":@"open_issues_count",
        @"forks":@"forks",
        @"open_issues":@"open_issues",
        @"watchers":@"watchers",
        @"default_branch":@"default_branch",
        @"score":@"score"
    };
}

+ (NSValueTransformer *)msSerializationTransformerForKey:(NSString *)key
{
    if ( [@"owner" isEqualToString:key] )
        return [MSSerializationValueTransformer transformerForSerializedObjecOfClass:[MSGithubOwnerContainer class]];
    return nil;
}

#pragma mark - MSSearchResultCellViewModel

- (NSString *)cellViewModelTitle
{
    return self.name;
}

- (NSString *)cellViewModelDetail
{
    return self.html_url;
}

- (NSURL *)cellViewModelImageURL
{
    return [NSURL URLWithString:self.owner.avatar_url];
}

@end
