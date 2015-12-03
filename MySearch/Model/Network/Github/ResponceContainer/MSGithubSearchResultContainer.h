//
//  MSGithubSearchResultContainer.h
//  MySearch
//
//  Created by Alexander Sviridov on 03/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSSerializationManager.h"
#import "MSSearchResultContainerProtocol.h"

@class MSGithubSearchResultEntryContainer;

@interface MSGithubSearchResultContainer : NSObject <MSSerializationObjectProtocol, MSSearchResultContainerProtocol>

@property NSInteger totalCount;
@property BOOL incompleteResults;
@property NSArray<MSGithubSearchResultEntryContainer *> *items;

@end
