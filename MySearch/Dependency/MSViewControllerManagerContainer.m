//
//  MSViewControllerManagerContainer.m
//  MySearch
//
//  Created by Alexander Sviridov on 03/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSViewControllerManagerContainer.h"

@implementation MSViewControllerManagerContainer

+ (instancetype)networkManagerWithManager:(id<MSNetworkManagerProtocol>)manager name:(NSString *)name
{
    MSViewControllerManagerContainer *container = [MSViewControllerManagerContainer new];
    container.networkManager = manager;
    container.name = name;
    return container;
}

@end
