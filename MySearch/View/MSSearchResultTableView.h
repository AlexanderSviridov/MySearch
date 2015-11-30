//
//  MSSearchResultTableView.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSSearchResultCellViewModel;

static CGFloat kMSSearchResultTableViewCellHeight = 100.;

@interface MSSearchResultTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) IBOutlet UIView *headerView;

@property (nonatomic) NSArray<id<MSSearchResultCellViewModel>> *cellArray;

@end
