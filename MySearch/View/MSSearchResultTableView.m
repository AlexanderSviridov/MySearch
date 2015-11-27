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

static NSString *kMSSearchResultTableViewRightCellIdentifier = @"kMSSearchResultTableViewRightCellIdentifier";
static NSString *kMSSearchResultTableViewLeftCellIdentifier = @"kMSSearchResultTableViewLeftCellIdentifier";

@implementation MSSearchResultTableView

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell<MSSearchResultCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:kMSSearchResultTableViewLeftCellIdentifier forIndexPath:indexPath];
    [cell configureCellFromModel:_cellArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kMSSearchResultTableViewCellHeight;
}

@end
