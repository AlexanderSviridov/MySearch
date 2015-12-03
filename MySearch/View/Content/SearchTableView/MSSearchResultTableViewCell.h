//
//  MSLeftAlignedSearchResultTableViewCell.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSSearchResultCellProtocol.h"

@class MSWebImageView;

@interface MSSearchResultTableViewCell : UITableViewCell <MSSearchResultCellProtocol>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property MSWebImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UIButton *ImageButton;

@end
