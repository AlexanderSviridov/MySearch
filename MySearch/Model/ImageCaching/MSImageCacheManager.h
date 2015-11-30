//
//  MSImageCacheManager.h
//  MySearch
//
//  Created by Alexander Sviridov on 30/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MSImageCacheManagerLoadedFrom){
    MSImageCacheManagerLoadedFromFile,
    MSImageCacheManagerLoadedFromCache,
    MSImageCacheManagerLoadedFromNetwork,
    MSImageCacheManagerLoadedFromError,
};

@interface MSImageCacheManager : NSObject

+ (instancetype)sharedManager;

- (void)loadCachedImageFromURL:(NSURL *)url compleationHandler:(void(^)(UIImage *, MSImageCacheManagerLoadedFrom))block;

@end
