//
//  MSSearchResultCellViewModel.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSSearchResultCellViewModel <NSObject>

@property (readonly) NSString *cellViewModelTitle;
@property (readonly) NSString *cellViewModelDetail;
@property (readonly) NSURL *cellViewModelImageURL;

@end
