//
//  MSImageView.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSWebImageView.h"
#import "MSImageCacheManager.h"

@implementation MSWebImageView
{
    NSURLSessionDataTask *_dataTask;
    UIActivityIndicatorView *_spinner;
    UIImageView *_imageView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if ( self )
    {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _spinner.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        _imageView = [[UIImageView alloc] init];
    }
    return self;
}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    __weak typeof(self) weakself = self;
    [_dataTask cancel];
    self.layer.contents = nil;
    self.backgroundColor = [UIColor clearColor];
    [_imageView removeFromSuperview];
    [self addSubview:_spinner];
    [_spinner startAnimating];
    _dataTask = [MSImageCacheManager.sharedManager loadCachedImageFromURL:imageURL compleationHandler:^(UIImage *image, MSImageCacheManagerLoadedFrom loadedFrom) {
        if ( MSImageCacheManagerLoadedFromCache == loadedFrom )
        {
            [weakself addSubview:_imageView];
            _imageView.image = image;
            [_spinner stopAnimating];
            [_spinner removeFromSuperview];
            return;
        }
        if ( MSImageCacheManagerLoadedFromError == loadedFrom )
        {
            [_spinner stopAnimating];
            [_spinner removeFromSuperview];
            self.backgroundColor = [UIColor colorWithHue:0 saturation:.8 brightness:1 alpha:1];
            return;
        }
        _imageView.image = image;
        [UIView transitionFromView:_spinner toView:_imageView duration:.3 options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseOut completion:^(BOOL finished) {
            [_spinner stopAnimating];
        }];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _spinner.frame = self.bounds;
    _imageView.frame = self.bounds;
}

@end
