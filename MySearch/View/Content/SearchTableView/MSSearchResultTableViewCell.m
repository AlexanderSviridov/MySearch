//
//  MSLeftAlignedSearchResultTableViewCell.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSSearchResultTableViewCell.h"

#import "MSWebImageView.h"
#import "MSSearchResultCellViewModel.h"
#import "MSWebImageView.h"
#import "MSEdgeContainerView.h"

@interface MSSearchResultTableViewCell ()

@property MSEdgeContainerView *edgeImageContainerView;

@end

@implementation MSSearchResultTableViewCell

@synthesize imageButtonHavePressed;

- (void)awakeFromNib
{
    // Initialization code
    self.cellImageView = [MSWebImageView new];
    self.edgeImageContainerView = [MSEdgeContainerView containerViewWithView:self.cellImageView withEdgeInsets:UIEdgeInsetsZero];
    self.edgeImageContainerView.userInteractionEnabled = NO;
    [self.ImageButton addSubview:self.edgeImageContainerView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellFromModel:(id<MSSearchResultCellViewModel>)cellModel
{
    self.titleLabel.text = [cellModel cellViewModelTitle];
    self.descriptionLabel.text = [cellModel cellViewModelDetail];
    self.cellImageView.imageURL = [cellModel cellViewModelImageURL];
    self.cellImageView.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.edgeImageContainerView.frame = self.ImageButton.bounds;
}

- (IBAction)ImageButtonDidPressed:(UIButton *)sender
{
    if ( self.imageButtonHavePressed )
        self.imageButtonHavePressed();
}

- (MSWebImageView *)unattachImageViewFromCell
{
    MSWebImageView *imageView = self.cellImageView;
    self.edgeImageContainerView.containerView = nil;
    self.cellImageView = nil;
    return imageView;
}

- (void)attachImageView:(MSWebImageView *)imageView
{
    self.edgeImageContainerView.containerView = imageView;
    [self.edgeImageContainerView addSubview:imageView];
    self.cellImageView = imageView;
}

@end
