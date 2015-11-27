//
//  NSArray+MSLinqExtension.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MSLinqExtension)

- (instancetype)linq_map:(id (^)(id))mappingBlock;

@end
