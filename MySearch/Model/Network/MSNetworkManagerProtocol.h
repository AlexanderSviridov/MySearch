//
//  MSNetworkManagerProtocol.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSPromise.h"

@protocol MSSearchResultContainerProtocol;

@protocol MSNetworkManagerProtocol <NSObject>

- (MSPromise<id<MSSearchResultContainerProtocol>> *)searchWithQuery:(NSString *)query;

- (MSPromise<id<MSSearchResultContainerProtocol>> *)getMoreResults;

@end
