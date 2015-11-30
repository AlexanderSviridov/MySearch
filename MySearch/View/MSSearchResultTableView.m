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

@interface MSSearchResultTableView ()

@end

static NSString *kMSSearchResultTableViewRightCellIdentifier = @"kMSRightSearchResultTableViewIdentifier";
static NSString *kMSSearchResultTableViewLeftCellIdentifier = @"kMSLeftSearchResultTableViewIdentifier";

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
    }
    return self;
}

- (void)setCellArray:(NSArray<id<MSSearchResultCellViewModel>> *)cellArray
{
    [self beginUpdates];
    [self reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    _cellArray = [cellArray copy];
    [self endUpdates];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cellArray count];
}

- (void)setHeaderView:(UIView *)headerView
{
    _headerView = headerView;
    [self addSubview:headerView];
    _defaultInset = self.contentInset;
    self.contentInset = ({
        UIEdgeInsets inset = self.contentInset;
        inset.top += 50;
        inset;
    });
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell<MSSearchResultCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:indexPath.row%2? kMSSearchResultTableViewLeftCellIdentifier : kMSSearchResultTableViewRightCellIdentifier forIndexPath:indexPath];
    [cell configureCellFromModel:_cellArray[indexPath.row]];
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.headerView.frame = (CGRect){
        .origin.y = self.bounds.origin.y + self.contentInset.top - 50,
        .origin.x = self.bounds.origin.x,
        .size.height = 50,
        .size.width = self.bounds.size.width
    };
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return _headerView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50.;
//}

@end
