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

@end

@implementation MSGithubNetworkManager

- (MSPromise *)searchGithubRepositoryWithQuery:(NSString *)query page:(NSInteger)page
{
    NSString *quertyString = [NSString stringWithFormat:@"https://api.github.com/search/repositories?q=%@&sort=stars&order=desc", query ];
    if ( page )
        quertyString = [quertyString stringByAppendingString:[NSString stringWithFormat:@"&page=%d", (int)page + 1]];
    quertyString = [quertyString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"%s %@", __PRETTY_FUNCTION__, quertyString);
    return [[self getJSONObjectWithURL:[NSURL URLWithString:quertyString]] then:^id(NSDictionary *responce) {
        return [MSSerializationManager serializedObjectFromRepresentation:responce class:[MSGithubSearchResultContainer class]];
    }];
}

- (MSPromise<id<MSSearchResultContainerProtocol>> *)searchWithQuery:(NSString *)query
{
    self.query = query;
    self.page = 0;
    return [self searchGithubRepositoryWithQuery:query page:0];
}

- (MSPromise<id<MSSearchResultContainerProtocol>> *)getMoreResults
{
    self.page ++;
    return [self searchGithubRepositoryWithQuery:self.query page:self.page];
}

@end
