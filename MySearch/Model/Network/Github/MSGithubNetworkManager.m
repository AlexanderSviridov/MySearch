//
//  MSGithubNetworkManager.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSGithubNetworkManager.h"
#import "MSSerializationManager.h"
#import "MSGithubSearchResultEntryContainer.h"
#import "MSSearchResultContainerProtocol.h"
#import "MSGithubSearchResultContainer.h"

@interface MSGithubNetworkManager ()

@property NSInteger page;
@property NSString *query;
@property MSPromise *currentPromise;

@end

@implementation MSGithubNetworkManager

- (MSPromise *)searchGithubRepositoryWithQuery:(NSString *)query page:(NSInteger)page
{
    NSString *quertyString = [NSString stringWithFormat:@"https://api.github.com/search/repositories?q=%@&sort=stars&order=desc", query ];
    if ( page )
        quertyString = [quertyString stringByAppendingString:[NSString stringWithFormat:@"&page=%d", (int)page + 1]];
    quertyString = [quertyString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [[self getJSONObjectWithURL:[NSURL URLWithString:quertyString]] then:^id(NSDictionary *responce) {
        return [MSSerializationManager serializedObjectFromRepresentation:responce class:[MSGithubSearchResultContainer class]];
    }];
}

- (MSPromise<id<MSSearchResultContainerProtocol>> *)searchWithQuery:(NSString *)query
{
    self.query = query;
    if ( [self.query isEqualToString:query] && self.page == 0 && self.currentPromise )
        return self.currentPromise;
    self.page = 0;
    return self.currentPromise = [self searchGithubRepositoryWithQuery:query page:0];
}

- (MSPromise<id<MSSearchResultContainerProtocol>> *)getMoreResults
{
    self.page ++;
    return [self searchGithubRepositoryWithQuery:self.query page:self.page];
}

@end
