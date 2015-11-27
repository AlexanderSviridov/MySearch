//
//  MSLeftAlignedSearchResultTableViewCell.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSLeftAlignedSearchResultTableViewCell.h"

#import "MSImageView.h"
#import "MSSearchResultCellViewModel.h"

@interface MSLeftAlignedSearchResultTableViewCell ()
//@property (weak, nonatomic) IBOutlet MSImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation MSLeftAlignedSearchResultTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellFromModel:(id<MSSearchResultCellViewModel>)cellModel
{
//    self.imageView.imageURL = [cellModel cellViewModelImageURL];
    self.titleLabel.text = [cellModel cellViewModelTitle];
    self.descriptionLabel.text = [cellModel cellViewModelDetail];
}

@end
