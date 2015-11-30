//
//  MSImageView.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSImageView.h"

@implementation MSImageView
{
    NSURLSessionDataTask *_dataTask;
    UIActivityIndicatorView *_spinner;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if ( self )
    {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return self;
}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    __weak typeof(self) weakself = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:2];
    [_dataTask cancel];
    self.layer.contents = nil;
    [self addSubview:_spinner];
    [_spinner startAnimating];
    _dataTask = [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            weakself.layer.contents = (id)image.CGImage;
            [_spinner stopAnimating];
            [_spinner removeFromSuperview];
        });
    }];
    [_dataTask resume];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _spinner.frame = self.bounds;
}

@end
