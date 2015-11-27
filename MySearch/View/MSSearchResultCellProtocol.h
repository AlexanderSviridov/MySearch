//
//  MSSearchResultCellProtocol.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSSearchResultCellViewModel;

@protocol MSSearchResultCellProtocol <NSObject>

- (void)configureCellFromModel:(id<MSSearchResultCellViewModel>)cellModel;

@end
