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
//        self.backgroundColor = [UIColor colorWithHue:0 saturation:0.6 brightness:1 alpha:1];
        self.layer.backgroundColor = [UIColor colorWithHue:0 saturation:0.6 brightness:1 alpha:1].CGColor;
        _imageView = [UIView new];
        _imageView.layer.contents = (id)MSErrorView.errorViewImage.CGImage;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = UIEdgeInsetsInsetRect(self.bounds, (UIEdgeInsets){
        .top = 20,
        .left = 20,
        .right = 20,
        .bottom = 20
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
