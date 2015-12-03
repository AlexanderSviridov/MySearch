//
//  MSPreviewContentView.h
//  MySearch
//
//  Created by Alexander Sviridov on 03/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSPromise.h"

@class MSWebImageView;

@interface MSPreviewContentView : UIView

@property UIButton *contentButton;
@property CGRect startingRect;

- (void)animateImageView:(MSWebImageView *)imageView;
- (MSPromise<MSWebImageView *> *)animateBackImageView;

@end
