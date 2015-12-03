//
//  MSSearchResultTableView.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSSearchResultTableView.h"
#import "MSSearchResultCellViewModel.h"
#import "MSSearchResultCellProtocol.h"
#import "NSArray+MSLinqExtension.h"
#import "MSSearchResultEmptyTableViewCell.h"

@interface MSSearchResultTableView ()

@end

static NSString *kMSSearchResultTableViewRightCellIdentifier = @"kMSRightSearchResultTableViewIdentifier";
static NSString *kMSSearchResultTableViewLeftCellIdentifier = @"kMSLeftSearchResultTableViewIdentifier";
static NSString *kMSSearchResultTableViewEmptyCellIndentufuer = @"kMSSearchResultTableViewEmptyCellIndentufuer";

@implementation MSSearchResultTableView
{
    UIEdgeInsets _defaultInset;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if ( self )
    {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundView = nil;
        self.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0);
        self.backgroundColor = [UIColor whiteColor];
        self.isAllCells = YES;
    }
    return self;
}

- (void)setCellArray:(NSArray<id<MSSearchResultCellViewModel>> *)cellArray
{
    [self beginUpdates];
    [self reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    _cellArray = [cellArray copy];
    [self endUpdates];
    [self layoutSubviews];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( !self.isAllCells )
        return [_cellArray count] + 1;
    return [_cellArray count];
}

- (void)insertCells:(NSArray<id<MSSearchResultCellViewModel>> *)cells
{
    [self beginUpdates];
//    [self reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    __block NSInteger index = _cellArray.count;
    [self insertRowsAtIndexPaths:[NSArray arrayWithBlock:^id{
        return [NSIndexPath indexPathForRow:index++ inSection:0];
    } count:cells.count] withRowAnimation:UITableViewRowAnimationFade];
    _cellArray = [_cellArray arrayByAddingObjectsFromArray:cells];
    [self endUpdates];
    [self layoutSubviews];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row >= _cellArray.count )
    {
        MSSearchResultEmptyTableViewCell *emptyCell = [tableView dequeueReusableCellWithIdentifier:kMSSearchResultTableViewEmptyCellIndentufuer forIndexPath:indexPath];
        [emptyCell.spiner startAnimating];
        if ( self.getMoreCells )
            self.getMoreCells(self);
        return emptyCell;
    }
    UITableViewCell<MSSearchResultCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:indexPath.row%2? kMSSearchResultTableViewRightCellIdentifier : kMSSearchResultTableViewLeftCellIdentifier forIndexPath:indexPath];
    id<MSSearchResultCellViewModel> model = _cellArray[indexPath.row];
    [cell configureCellFromModel:model];
    __weak MSSearchResultTableView *self_weak = self;
    __weak UITableViewCell<MSSearchResultCellProtocol> *cell_weak = cell;
    [cell setImageButtonHavePressed:^{
        if ( self_weak.imageButtonHavePressedWithModel )
            self_weak.imageButtonHavePressedWithModel(model, cell_weak);
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kMSSearchResultTableViewCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kMSSearchResultTableViewCellHeight;
}

@end
