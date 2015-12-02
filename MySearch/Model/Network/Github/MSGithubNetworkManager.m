//
//  MSGithubNetworkManager.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSGithubNetworkManager.h"
#import "MSSerializationManager.h"
#import "MSGithubSearchResultContainer.h"

@implementation MSGithubNetworkManager

- (void)searchRepositoriesWithQuery:(NSString *)queryString onCompleation:(void (^)())compleation
{
    
}

- (MSPromise<NSArray<id<MSSearchResultCellViewModel>> *> *)searchWithQuery:(NSString *)query
{
    NSString *quertyString = [NSString stringWithFormat:@"https://api.github.com/search/repositories?q=%@&sort=stars&order=desc", query ];
    quertyString = [quertyString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [[self getJSONObjectWithURL:[NSURL URLWithString:quertyString]] then:^id(NSDictionary *responce) {
        NSArray *items = responce[@"items"];
        items = [MSSerializationManager serializedObjectFromArrayRepresentation:items class:[MSGithubSearchResultContainer class]];
        return items;
    }];
}

@end
