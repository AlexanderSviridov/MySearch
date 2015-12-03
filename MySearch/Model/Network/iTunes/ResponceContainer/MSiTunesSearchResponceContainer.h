//
//  MSiTunesSearchResponceContainer.h
//  MySearch
//
//  Created by Alexander Sviridov on 02/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSSerializationManager.h"
#import "MSSearchResultContainerProtocol.h"

@class MSiTunesSearchResponceEntityContainer;

@interface MSiTunesSearchResponceContainer : NSObject <MSSerializationObjectProtocol, MSSearchResultContainerProtocol>

@property NSInteger resultCount;
@property NSArray<MSiTunesSearchResponceEntityContainer *> *results;

@end
