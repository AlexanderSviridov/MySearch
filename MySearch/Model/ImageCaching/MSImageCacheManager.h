//
//  MSImageCacheManager.h
//  MySearch
//
//  Created by Alexander Sviridov on 30/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "MSPromise.h"

typedef NS_ENUM(NSInteger, MSImageCacheManagerLoadedFrom){
    MSImageCacheManagerLoadedFromFile,
    MSImageCacheManagerLoadedFromCache,
    MSImageCacheManagerLoadedFromNetwork,
};

@interface MSImageCacheLoadImageContainer : NSObject

@property MSImageCacheManagerLoadedFrom loadedFrom;
@property UIImage *image;

@end

@interface MSImageCacheManager : NSObject

+ (instancetype)sharedManager;

- (MSPromise<MSImageCacheLoadImageContainer *> *)loadCachedImageFromURL:(NSURL *)url;

@end
