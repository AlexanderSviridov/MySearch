//
//  UIViewController+ShowModal.h
//  AQUA Analytics
//
//  Created by Alexander Sviridov on 16/05/14.
//  Copyright (c) 2014 OysterLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ShowModal)

- (void)showModalWithDuration:(NSTimeInterval)duration;

- (void)showModalFromViewController:(UIViewController *)parrentViewController withDuration:(NSTimeInterval)duration;

- (void)hideModalWithDuration:(NSTimeInterval)duration;

- (void)hideModalWithDuration:(NSTimeInterval)duration compleation:(void(^)())compleationBlock;

@end
