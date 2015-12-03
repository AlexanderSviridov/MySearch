//
//  MSLoadingScreenView.h
//  MySearch
//
//  Created by Alexander Sviridov on 03/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSLoadingScreenView : UIView

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, weak) IBOutlet UILabel *queryLabel;
@property (nonatomic, weak) IBOutlet UILabel *serviceLabel;
@property (nonatomic, weak) IBOutlet UIView *alertView;

- (void)startAnimationWithQuery:(NSString *)querty serviceName:(NSString *)service;

- (void)stopAnimating;

@end
