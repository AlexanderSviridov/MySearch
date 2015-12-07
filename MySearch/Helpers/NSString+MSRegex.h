//
//  NSString+MSRegex.h
//  MySearch
//
//  Created by Alexander Sviridov on 07/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MSRegex)

- (instancetype)stringByRemovingRegex:(NSString *)regex;

@end
