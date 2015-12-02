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
    return [MSPromise newPromise:^MSPromiseDisposable(MSPromiseFullfillBlock fullfil, MSPromiseRejectBclock reject) {
        NSString *quertyString = [NSString stringWithFormat:@"https://api.github.com/search/repositories?q=%@&sort=stars&order=desc", query ];
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:quertyString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSError *__autoreleasing err;
            if ( !data )
            {
                reject(error);
                return;
            }
            id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            if ( err )
            {
                reject(err);
                return;
            }
            NSArray *items = result[@"items"];
            items = [MSSerializationManager serializedObjectFromArrayRepresentation:items class:[MSGithubSearchResultContainer class]];
            fullfil( items );
        }];
        [dataTask resume];
        return ^{
            [dataTask cancel];
        };
    }];
}

@end
