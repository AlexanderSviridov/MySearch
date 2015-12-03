//
//  MSLoadingScreenView.m
//  MySearch
//
//  Created by Alexander Sviridov on 03/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSLoadingScreenView.h"

@implementation MSLoadingScreenView

- (void)awakeFromNib
{
//    self.alertView.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.alertView.layer.borderWidth = 4;
}

- (void)startAnimationWithQuery:(NSString *)querty serviceName:(NSString *)service
{
    self.hidden = NO;
    self.alpha = 0;
    self.queryLabel.text = [NSString stringWithFormat:@"query: %@", querty ];
    self.serviceLabel.text = service;
    [self.spinner startAnimating];
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 1;
    }];
 }

- (void)stopAnimating
{
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self.spinner stopAnimating];
    }];
}

@end
