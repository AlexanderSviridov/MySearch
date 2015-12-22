//
//  MSSearchResultTableView.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSPromise.h"

@protocol MSSearchResultCellViewModel;
@protocol MSSearchResultCellProtocol;

static CGFloat kMSSearchResultTableViewCellHeight = 100.;

@interface MSSearchResultTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) BOOL isAllCells;

@property (nonatomic) NSArray<id<MSSearchResultCellViewModel>> *cellArray;

@property (copy) void(^imageButtonHavePressedWithModel)(id<MSSearchResultCellViewModel> model, id<MSSearchResultCellProtocol> cell);

- (MSPromise<MSSearchResultTableView *> *)getMoreCells;

- (void)insertCells:(NSArray<id<MSSearchResultCellViewModel>> *)cells;

@end
