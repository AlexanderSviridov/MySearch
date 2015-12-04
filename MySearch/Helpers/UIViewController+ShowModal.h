//
//  UIViewController+ShowModal.h
//  MySearch
//
//  Created by Alexander Sviridov on 16/05/14.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ShowModal)

- (void)showModalWithDuration:(NSTimeInterval)duration;

- (void)showModalFromViewController:(UIViewController *)parrentViewController withDuration:(NSTimeInterval)duration;

- (void)hideModalWithDuration:(NSTimeInterval)duration;

- (void)hideModalWithDuration:(NSTimeInterval)duration compleation:(void(^)())compleationBlock;

@end
