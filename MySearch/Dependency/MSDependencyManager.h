//
//  MSDependencyManager.h
//  MySearch
//
//  Created by Alexander Sviridov on 03/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSDependencyManager : NSObject

+ (instancetype)sharedManager;

- (void)getDependenciesForObject:(id)object;
- (id)getObjectFromProtocol:(Protocol*)protocol forObject:(id)object;

@end
