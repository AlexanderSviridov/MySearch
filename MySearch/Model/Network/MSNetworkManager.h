//
//  MSNetworkManager.h
//  MySearch
//
//  Created by Alexander Sviridov on 02/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSPromise.h"

@interface MSNetworkManager : NSObject

- (MSPromise<NSData *> *)getDataWithURL:(NSURL *)url;
- (MSPromise *)getJSONObjectWithURL:(NSURL *)url;

@end
