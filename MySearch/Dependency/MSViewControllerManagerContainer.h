//
//  MSViewControllerManagerContainer.h
//  MySearch
//
//  Created by Alexander Sviridov on 03/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSNetworkManagerProtocol;

@interface MSViewControllerManagerContainer : NSObject

@property id<MSNetworkManagerProtocol> networkManager;
@property (copy) NSString *name;

+ (instancetype)networkManagerWithManager:(id<MSNetworkManagerProtocol>)manager name:(NSString *)name;

@end
