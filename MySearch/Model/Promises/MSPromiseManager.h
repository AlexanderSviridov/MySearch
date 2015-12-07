//
//  MSPromiseManager.h
//  MySearch
//
//  Created by Alexander Sviridov on 07/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSPromise;

@interface MSPromiseManager : NSObject

+ (instancetype)sharedManager;

- (void)addPromiseToObserve:(MSPromise *)promise;

- (void)printListOfCurrentPromises;

@end
