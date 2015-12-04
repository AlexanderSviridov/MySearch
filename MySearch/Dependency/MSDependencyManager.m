//
//  MSDependencyManager.m
//  MySearch
//
//  Created by Alexander Sviridov on 03/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSDependencyManager.h"

#import <objc/runtime.h>

#import "MSViewController.h"
#import "MSGithubNetworkManager.h"
#import "MSiTunesNetworkManager.h"
#import "MSPreviewViewController.h"
#import "MSPreviewViewController.h"

@implementation MSDependencyManager
{
    MSGithubNetworkManager *_githubManager;
    MSiTunesNetworkManager *_iTunesManager;
    MSPreviewViewController *_previewController;
}

+ (instancetype)sharedManager
{
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [self new];
    });
    return singleton;
}

- (instancetype)init
{
    self = [super init];
    if ( self )
    {
        _githubManager = [MSGithubNetworkManager new];
        _iTunesManager = [MSiTunesNetworkManager new];
        _previewController = [MSPreviewViewController new];
    }
    return self;
}

- (void)getDependenciesForObject:(id)object
{
    if ( [object isKindOfClass:[MSViewController class]] )
    {
        MSViewController *vc = object;
        vc.networkManagers = @[
            [MSViewControllerManagerContainer networkManagerWithManager:_githubManager name:@"Github"],
            [MSViewControllerManagerContainer networkManagerWithManager:_iTunesManager name:@"iTunes"]
        ];
        vc.previewController = _previewController;
    }
}

@end
