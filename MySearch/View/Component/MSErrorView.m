//
//  MSErrorView.m
//  MySearch
//
//  Created by Alexander Sviridov on 01/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSErrorView.h"

@implementation MSErrorView
{
    UIView *_imageView;
}

+ (UIImage *)errorViewImage
{
    static UIImage *errorImage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        errorImage = [UIImage imageNamed:@"white_close_x"];
    });
    return errorImage;
}

- (instancetype)init
{
    self = [super init];
    if ( self )
    {
        self.layer.backgroundColor = [UIColor colorWithHue:0 saturation:0.6 brightness:1 alpha:1].CGColor;
        _imageView = [UIView new];
        _imageView.layer.contents = (id)MSErrorView.errorViewImage.CGImage;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        self.insets = (UIEdgeInsets){ 20, 20, 20, 20 };
        self.containerView = _imageView;
    }
    return self;
}

@end
