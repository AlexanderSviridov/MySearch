//
//  MSTextField.m
//  MySearch
//
//  Created by Alexander Sviridov on 02/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSSearchTextField.h"
#import "MSEdgeContainerView.h"

@implementation MSSearchTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (CGRect)borderRectForBounds:(CGRect)bounds;

+ (UIImage *)searchImage
{
    static UIImage *image = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        image = [UIImage imageNamed:@"search-icon-hi"];
    });
    return image;
}

- (instancetype)initWithCoder:(NSCoder *)aDecode
{
    self = [super initWithCoder:aDecode];
    if ( self ) {
        MSEdgeContainerView *leftImageView = [MSEdgeContainerView containerViewWithView:({
            UIView *imageView = [UIView new];
            imageView.layer.contents = (id)MSSearchTextField.searchImage.CGImage;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.userInteractionEnabled = NO;
            imageView;
        }) withEdgeInsets:(UIEdgeInsets){ .top = 15, .left = 15, .right = 15, .bottom = 15 }];
        leftImageView.backgroundColor = [UIColor colorWithRed:0.1738 green:0.4198 blue:0.9984 alpha:1.0];
        leftImageView.userInteractionEnabled = NO;
        self.leftView = leftImageView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect(bounds, kMSTextFieldTextInsets );
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect(bounds, kMSTextFieldTextInsets );
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect(bounds, kMSTextFieldTextInsets );
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    return (CGRect){
        .origin = bounds.origin,
        .size.width = bounds.size.height,
        .size.height = bounds.size.height
    };
}

@end
