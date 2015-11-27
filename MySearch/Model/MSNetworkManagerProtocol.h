//
//  MSNetworkManagerProtocol.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSNetworkManagerProtocol <NSObject>

- (void)searchWithQuery:(NSString *)query compleationBlock:(void(^)(NSArray *results))compleation;

@end
