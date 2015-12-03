//
//  MSImageView.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSWebImageView.h"
#import "MSImageCacheManager.h"
#import "MSPromise.h"
#import "MSErrorView.h"

@implementation MSWebImageView
{
    MSPromise *_loadImagePromise;
    UIActivityIndicatorView *_spinner;
    UIImageView *_imageView;
    MSErrorView *_errorView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if ( self )
    {
        [self loadViews];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadViews];
    }
    return self;
}

- (void)loadViews
{
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _spinner.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _errorView = [MSErrorView new];
}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    __weak typeof(self) weakself = self;
    [_loadImagePromise dispose];
    self.layer.contents = nil;
    [_imageView removeFromSuperview];
    [_errorView removeFromSuperview];
    [self addSubview:_spinner];
    [_spinner startAnimating];
    __weak MSWebImageView *self_weak = self;
    _loadImagePromise = [[[MSImageCacheManager.sharedManager loadCachedImageFromURL:
//                           [NSURL URLWithString:@"http://www.google.com"]
                           imageURL
                           ] then:^MSPromise *(MSImageCacheLoadImageContainer *container) {
        if ( ![self_weak.imageURL isEqual:imageURL] )
            return nil;
        if ( MSImageCacheManagerLoadedFromCache == container.loadedFrom )
        {
            [weakself addSubview:_imageView];
            _imageView.image = container.image;
            [_spinner stopAnimating];
            [_spinner removeFromSuperview];
            return nil;
        }
        _imageView.image = container.image;
        [UIView transitionFromView:_spinner toView:_imageView duration:.3 options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseOut completion:nil];
        return nil;
    }] catch:^MSPromise *(NSError *error) {
        NSLog(@"%@", error );
        [UIView transitionFromView:_spinner toView:_errorView duration:.3 options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseOut completion:nil];
        return nil;
    }];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _spinner.frame = self.bounds;
    _imageView.frame = self.bounds;
    _errorView.frame = self.bounds;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _spinner.frame = self.bounds;
    _imageView.frame = self.bounds;
    _errorView.frame = self.bounds;
}

@end
