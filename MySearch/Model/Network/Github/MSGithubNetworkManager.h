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

@interface MSGithubNetworkManager : MSNetworkManager <MSNetworkManagerProtocol>

- (void)searchRepositoriesWithQuery:(NSString *)queryString onCompleation:(void(^)())compleation;

@end
