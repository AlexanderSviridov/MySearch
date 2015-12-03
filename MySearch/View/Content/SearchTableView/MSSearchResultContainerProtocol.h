//
//  MSSearchResultContainerProtocol.h
//  MySearch
//
//  Created by Alexander Sviridov on 03/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSSearchResultCellViewModel;

@protocol MSSearchResultContainerProtocol <NSObject>

@property (readonly) BOOL isIncompleteResult;
@property (readonly) NSArray<id<MSSearchResultCellViewModel>> *cellArray;

@end
