//
//  MSPreviewViewController.h
//  MySearch
//
//  Created by Alexander Sviridov on 03/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSWebImageView;

@interface MSPreviewViewController : UIViewController

@property (nonatomic) MSWebImageView *transferImageView;
@property CGRect startingFrame;

@property (copy) void(^compleationHandler)(MSPreviewViewController *);

@end
