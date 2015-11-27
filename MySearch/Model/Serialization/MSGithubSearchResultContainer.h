//
//  MSGithubSearchResultContainer.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSSerializationManager.h"

/**
 *  MSGithubSearchResultContainer
 *  Expected array responce for https://api.github.com/search/repositories request
 *  info: https://developer.github.com/v3/search/
 */
@interface MSGithubSearchResultContainer : NSObject <MSSerializationObjectProtocol>

@property NSInteger container_id;
@property NSString *name;
@property NSString *full_name;
@property NSDictionary *owner;
@property BOOL container_private;
@property NSString *html_url;
@property NSString *container_description;
@property BOOL fork;
@property NSString *url;
@property NSString *forks_url;
@property NSString *keys_url;
@property NSString *collaborators_url;
@property NSString *teams_url;
@property NSString *hooks_url;
@property NSString *issue_events_url;
@property NSString *events_url;
@property NSString *assignees_url;
@property NSString *branches_url;
@property NSString *tags_url;
@property NSString *blobs_url;
@property NSString *git_tags_url;
@property NSString *git_refs_url;
@property NSString *trees_url;
@property NSString *statuses_url;
@property NSString *languages_url;
@property NSString *stargazers_url;
@property NSString *contributors_url;
@property NSString *subscribers_url;
@property NSString *subscription_url;
@property NSString *commits_url;
@property NSString *git_commits_url;
@property NSString *comments_url;
@property NSString *issue_comment_url;
@property NSString *contents_url;
@property NSString *compare_url;
@property NSString *merges_url;
@property NSString *archive_url;
@property NSString *downloads_url;
@property NSString *issues_url;
@property NSString *pulls_url;
@property NSString *milestones_url;
@property NSString *notifications_url;
@property NSString *labels_url;
@property NSString *releases_url;
@property NSString *created_at;
@property NSString *updated_at;
@property NSString *pushed_at;
@property NSString *git_url;
@property NSString *ssh_url;
@property NSString *clone_url;
@property NSString *svn_url;
@property NSString *homepage;
@property NSInteger size;
@property NSInteger stargazers_count;
@property NSInteger watchers_count;
@property NSString *language;
@property BOOL has_issues;
@property BOOL has_downloads;
@property BOOL has_wiki;
@property BOOL has_pages;
@property NSInteger forks_count;
@property NSString *mirror_url;
@property NSInteger open_issues_count;
@property NSInteger forks;
@property NSInteger open_issues;
@property NSInteger watchers;
@property NSString *default_branch;
@property NSInteger score;

@end
