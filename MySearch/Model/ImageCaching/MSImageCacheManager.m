//
//  MSImageCacheManager.m
//  MySearch
//
//  Created by Alexander Sviridov on 30/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSImageCacheManager.h"

@implementation MSImageCacheManager
{
    NSCache<NSURL *, UIImage *> *_cached;
    NSCache<NSURL *, NSURLSessionDownloadTask *> *_networkTasks;
}

+ (instancetype)sharedManager
{
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (instancetype)init
{
    self = [super init];
    if ( self )
    {
        _cached = [[NSCache alloc] init];
    }
    return self;
}

- (void)loadCachedImageFromURL:(NSURL *)url compleationHandler:(void (^)(UIImage *, MSImageCacheManagerLoadedFrom))block
{
    if ( !url )
    {
        block(nil, MSImageCacheManagerLoadedFromError);
        return;
    }
    UIImage *cachedImage = [_cached objectForKey:url];
    if ( cachedImage )
    {
        block(cachedImage, MSImageCacheManagerLoadedFromCache);
        return;
    }
    NSURLSessionDataTask *_dataTask;
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:2];
    _dataTask = [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *resultImage = [UIImage imageWithData:data];
        block( resultImage, MSImageCacheManagerLoadedFromNetwork );
    }];
    [_dataTask resume];
}

@end
