//
//  MSGithubNetworkManager.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSNetworkManagerProtocol.h"
#import "MSNetworkManager.h"

@class MSGithubSearchResultContainer;

@interface MSGithubNetworkManager : MSNetworkManager <MSNetworkManagerProtocol>

- (MSPromise<MSGithubSearchResultContainer *> *)searchGithubRepositoryWithQuery:(NSString *)query page:(NSInteger)page;

@end
