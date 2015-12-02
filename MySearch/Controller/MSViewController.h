//
//  ViewController.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSNetworkManagerProtocol;

@interface MSViewControllerManagerContainer : NSObject

@property id<MSNetworkManagerProtocol> networkManager;
@property (copy) NSString *name;

+ (instancetype)networkManagerWithManager:(id<MSNetworkManagerProtocol>)manager name:(NSString *)name;

@end

@interface MSViewController : UIViewController

@property NSArray<MSViewControllerManagerContainer *> *networkManagers;

@end

