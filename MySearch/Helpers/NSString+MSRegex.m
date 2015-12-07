//
//  NSString+MSRegex.m
//  MySearch
//
//  Created by Alexander Sviridov on 07/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "NSString+MSRegex.h"

@implementation NSString (MSRegex)

- (instancetype)stringByRemovingRegex:(NSString *)regex
{
    __autoreleasing NSError *error = nil;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regex
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSRange rangeOfFirstMatch = [regularExpression rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    NSString *regexOccurentString = [self substringWithRange:rangeOfFirstMatch];
    return [self stringByReplacingOccurrencesOfString:regexOccurentString withString:@""];
}

@end
