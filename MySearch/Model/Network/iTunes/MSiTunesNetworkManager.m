//
//  MSiTunesNetworkManager.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSiTunesNetworkManager.h"

#import "MSSerializationManager.h"
#import "MSiTunesSearchResponceContainer.h"

@interface MSiTunesNetworkManager ()

@property NSInteger page;
@property NSString *query;
@property MSPromise *currentPromise;

@end

@implementation MSiTunesNetworkManager

- (MSPromise *)searchEntitiesWithQuery:(NSString *)query page:(NSInteger)page;
{
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@", [query stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    if ( page )
        urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&offset=%d", (int)page * 50 ]];
    return [[self getJSONObjectWithURL:[NSURL URLWithString:urlString]] then:^id(NSDictionary *resultDictionary) {
        return [MSSerializationManager serializedObjectFromRepresentation:resultDictionary class:[MSiTunesSearchResponceContainer class]];
    }];
}


- (MSPromise<id<MSSearchResultContainerProtocol>> *)searchWithQuery:(NSString *)query
{
    if ( self.page == 0 && [self.query isEqualToString:query] && self.currentPromise )
        return self.currentPromise;
    self.page = 0;
    self.query = query;
    return self.currentPromise = [[self searchEntitiesWithQuery:query page:0] catch:^MSPromise *(NSError *error) {
        self.query = nil;
        return nil;
    }];
}

- (MSPromise<id<MSSearchResultContainerProtocol>> *)getMoreResults
{
    self.page ++;
    return [self searchEntitiesWithQuery:self.query page:self.page];
}

@end
