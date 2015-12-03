//
//  MSPreviewViewController.m
//  MySearch
//
//  Created by Alexander Sviridov on 03/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSPreviewViewController.h"

#import "MSDependencyManager.h"
#import "MSPreviewContentView.h"
#import "UIViewController+ShowModal.h"
#import "MSWebImageView.h"

@interface MSPreviewViewController ()

//@property (nonatomic) id<MSShowModalTransictionProtocol> animator;

@end

@implementation MSPreviewViewController
{
    MSPreviewContentView *_contentView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_contentView.contentButton addTarget:self action:@selector(backButtonDidPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backButtonDidPressed
{
    [[_contentView animateBackImageView] then:^MSPromise *(MSWebImageView *imageView) {
        if ( self.compleationHandler )
            self.compleationHandler(self);
        [self hideModalWithDuration:0];
        return nil;
    }];
}

- (void)loadView
{
    self.view = _contentView = [MSPreviewContentView new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _contentView.backgroundColor = [UIColor clearColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_contentView animateImageView:self.transferImageView];
}

@end
