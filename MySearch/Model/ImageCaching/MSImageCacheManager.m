//
//  MSImageCacheManager.m
//  MySearch
//
//  Created by Alexander Sviridov on 30/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSImageCacheManager.h"
#import "MSPromise.h"

@implementation MSImageCacheLoadImageContainer

@end

@implementation MSImageCacheManager
{
    NSCache<NSURL *, UIImage *> *_cached;
    NSMutableDictionary<NSURL *, MSPromise<MSImageCacheLoadImageContainer *> *> *_networkTasks;
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
        _networkTasks = [NSMutableDictionary new];
    }
    return self;
}

- (MSPromise *)loadCachedImageFromURL:(NSURL *)url
{
    if ( !url )
        return [MSPromise promiseWithError:[NSError errorWithDomain:@"" code:0 userInfo:nil]];
    UIImage *cachedImage = [_cached objectForKey:url];
    if ( cachedImage ) {
        MSImageCacheLoadImageContainer *container = [MSImageCacheLoadImageContainer new];
        container.loadedFrom = MSImageCacheManagerLoadedFromCache;
        container.image = cachedImage;
        return [MSPromise promiseWithValue:container];
    }
    MSPromise *resultPromise = _networkTasks[url];
    if ( resultPromise )
        return resultPromise;
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:0];
    resultPromise =  [MSPromise newPromise:^MSPromiseDisposable(MSPromiseFullfillBlock fullfil, MSPromiseRejectBclock reject) {
        NSURLSessionDataTask *_dataTask = [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            MSImageCacheLoadImageContainer *container = [MSImageCacheLoadImageContainer new];
            [_networkTasks removeObjectForKey:url];
            UIImage *resultImage = [UIImage imageWithData:data];
            if ( error || !resultImage ) {
                reject([NSError errorWithDomain:@"" code:0 userInfo:nil]);
                return;
            }
            [_cached setObject:resultImage forKey:url];
            container.loadedFrom = MSImageCacheManagerLoadedFromNetwork;
            container.image = resultImage;
            fullfil( container );
        }];
        [_dataTask resume];
        return ^{
            [_dataTask cancel];
            [_networkTasks removeObjectForKey:url];
        };
    }];
    [_networkTasks setObject:resultPromise forKey:url];
    return resultPromise;
}

@end
