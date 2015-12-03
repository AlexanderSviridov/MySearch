//
//  MSEdgeContainerView.m
//  MySearch
//
//  Created by Alexander Sviridov on 02/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSEdgeContainerView.h"

@implementation MSEdgeContainerView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)containerViewWithView:(UIView *)containerView withEdgeInsets:(UIEdgeInsets)insets
{
    MSEdgeContainerView *resultView = [self new];
    resultView.containerView = containerView;
    resultView.insets = insets;
    [resultView addSubview:containerView];
    return resultView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.containerView.frame = UIEdgeInsetsInsetRect(self.bounds, self.insets );
}

@end
