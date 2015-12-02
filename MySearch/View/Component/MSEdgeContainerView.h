//
//  MSEdgeContainerView.h
//  MySearch
//
//  Created by Alexander Sviridov on 02/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSEdgeContainerView : UIView

+ (instancetype)containerViewWithView:(UIView *)containerView withEdgeInsets:(UIEdgeInsets)insets;

@end
