//
//  NSArray+MSLinqExtension.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (MSLinqExtension)

- (instancetype)linq_map:(id (^)(ObjectType))mappingBlock;

+ (NSArray *)arrayWithBlock:(id(^)())block count:(NSInteger)count;

@end
