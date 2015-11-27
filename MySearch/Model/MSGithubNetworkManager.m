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

- (void)searchWithQuery:(NSString *)query compleationBlock:(void (^)(NSArray<id<MSSearchResultCellViewModel>> *))compleation
{
    NSString *quertyString = [NSString stringWithFormat:@"https://api.github.com/search/repositories?q=%@&sort=stars&order=desc", query ];
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:quertyString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *__autoreleasing err;
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        NSArray *items = result[@"items"];
        items = [MSSerializationManager serializedObjectFromArrayRepresentation:items class:[MSGithubSearchResultContainer class]];
        dispatch_async(dispatch_get_main_queue(), ^{
            compleation( items );
        });
    }] resume];
}

@end
