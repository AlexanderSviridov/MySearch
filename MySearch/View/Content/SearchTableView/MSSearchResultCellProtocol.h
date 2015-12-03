//
//  MSSearchResultCellProtocol.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSSearchResultCellViewModel;
@class MSWebImageView;

@protocol MSSearchResultCellProtocol <NSObject>

@property (copy) void(^imageButtonHavePressed)();

- (void)configureCellFromModel:(id<MSSearchResultCellViewModel>)cellModel;

- (MSWebImageView *)unattachImageViewFromCell;
- (void)attachImageView:(MSWebImageView *)imageView;

@end
