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

@implementation MSiTunesNetworkManager

- (MSPromise *)searchEntitiesWithQuery:(NSString *)query;
{
//    https://itunes.apple.com/search?term=jack+johnson
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@", [query stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    return [[self getJSONObjectWithURL:[NSURL URLWithString:urlString]] then:^id(NSDictionary *resultDictionary) {
        return [MSSerializationManager serializedObjectFromRepresentation:resultDictionary class:[MSiTunesSearchResponceContainer class]];
    }];
}

- (MSPromise<NSArray<id<MSSearchResultCellViewModel>> *> *)searchWithQuery:(NSString *)query
{
    return [[self searchEntitiesWithQuery:query] then:^id(MSiTunesSearchResponceContainer *responce) {
        return responce.results;
    }];
}

@end
