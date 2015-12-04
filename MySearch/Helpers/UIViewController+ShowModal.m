//
//  UIViewController+ShowModal.m
//  MySearch
//
//  Created by Alexander Sviridov on 16/05/14.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "UIViewController+ShowModal.h"

@implementation UIViewController (ShowModal)

- (void)showModalWithDuration:(NSTimeInterval)duration
{
	[self showModalFromViewController:[[UIApplication sharedApplication].keyWindow rootViewController] withDuration:duration];
}

- (void)showModalFromViewController:(UIViewController *)parrentViewController withDuration:(NSTimeInterval)duration
{
	self.view.alpha = 0;
	__weak UIViewController *mainViewController = parrentViewController;
	
	[self willMoveToParentViewController:mainViewController];
    [self viewWillAppear:duration];
	[mainViewController.view addSubview:self.view];
	[mainViewController addChildViewController:self];
	self.view.frame = mainViewController.view.bounds;
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self didMoveToParentViewController:mainViewController];
	
	__weak typeof(self)_self = self;
	if ( duration )
	{
		[UIView animateWithDuration:duration animations:^{
			_self.view.alpha = 1;
		} completion:^(BOOL finished) {
            [_self viewDidAppear:YES];
        }];
	}
	else
	{
		self.view.alpha = 1;
        [_self viewDidAppear:NO];
	}
}

- (void)hideModalWithDuration:(NSTimeInterval)duration
{
	[self hideModalWithDuration:duration compleation:nil];
}

- (void)hideModalWithDuration:(NSTimeInterval)duration compleation:(void (^)())compleationBlock
{
	__weak typeof(self)_self = self;
	void (^_compleationBlock)() = compleationBlock ? [compleationBlock copy] : nil;
	if ( duration )
	{
		[UIView animateWithDuration:duration animations:^{
			_self.view.alpha = 0;
		} completion:^(BOOL finished) {
			[_self willMoveToParentViewController:nil];
			[_self.view removeFromSuperview];
			[_self removeFromParentViewController];
			_self.view.alpha = 1;
			[_self didMoveToParentViewController:nil];
			if ( _compleationBlock )
			{
				_compleationBlock();
			}
		}];
		return;
	}
	[self willMoveToParentViewController:nil];
	[self.view removeFromSuperview];
	[self removeFromParentViewController];
	self.view.alpha = 1;
	[self didMoveToParentViewController:nil];
}

@end
