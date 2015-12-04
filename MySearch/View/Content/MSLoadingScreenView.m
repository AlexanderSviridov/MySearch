//
//  MSLoadingScreenView.m
//  MySearch
//
//  Created by Alexander Sviridov on 03/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSLoadingScreenView.h"

#import "MSGlobalConstaints.h"

@implementation MSLoadingScreenView

- (void)startAnimationWithQuery:(NSString *)querty serviceName:(NSString *)service
{
    self.hidden = NO;
    self.alpha = 0;
    self.queryLabel.text = [NSString stringWithFormat:@"query: %@", querty ];
    self.serviceLabel.text = service;
    [self.spinner startAnimating];
    [UIView animateWithDuration:kMSDefaultAnimationDuration animations:^{
        self.alpha = 1;
    }];
 }

- (void)stopAnimating
{
    [UIView animateWithDuration:kMSDefaultAnimationDuration animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self.spinner stopAnimating];
    }];
}

@end
