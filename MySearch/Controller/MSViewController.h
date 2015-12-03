//
//  ViewController.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSViewControllerManagerContainer.h"

@protocol MSNetworkManagerProtocol;
@class MSPreviewViewController;

@interface MSViewController : UIViewController

@property NSArray<MSViewControllerManagerContainer *> *networkManagers;
@property MSPreviewViewController *previewController;

@end

