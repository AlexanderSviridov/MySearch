//
//  MSiTunesNetworkManager.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSNetworkManagerProtocol.h"
#import "MSNetworkManager.h"

@class MSiTunesSearchResponceContainer;

@interface MSiTunesNetworkManager : MSNetworkManager <MSNetworkManagerProtocol>

- (MSPromise<MSiTunesSearchResponceContainer *> *)searchEntitiesWithQuery:(NSString *)query;

@end
