
//
//  MSPreviewContentView.m
//  MySearch
//
//  Created by Alexander Sviridov on 03/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSPreviewContentView.h"

#import "MSWebImageView.h"

@implementation MSPreviewContentView
{
    MSWebImageView *_imageView;
}

- (instancetype)init
{
    self = [super init];
    if ( self )
    {
//        self.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
        _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_contentButton];
    }
    return self;
}

- (void)animateImageView:(MSWebImageView *)imageView
{
    _imageView = imageView;
    self.startingRect = [_imageView convertRect:_imageView.bounds toView:self];
    [self addSubview:_imageView];
    _imageView.frame = self.startingRect;
    _imageView.userInteractionEnabled = NO;
    [UIView animateWithDuration:.3 animations:^{
        _imageView.frame = self.bounds;
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _contentButton.frame = self.bounds;
    _imageView.frame = self.bounds;
}

- (MSPromise<MSWebImageView *> *)animateBackImageView
{
    MSWebImageView *imageView = _imageView;
    _imageView = nil;
    return [MSPromise newPromise:^MSPromiseDisposable(MSPromiseFullfillBlock fullfil, MSPromiseRejectBclock reject) {
        [UIView animateWithDuration:.3 animations:^{
            imageView.frame = self.startingRect;
            self.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            fullfil(imageView);
        }];
        return nil;
    }];
}

@end
