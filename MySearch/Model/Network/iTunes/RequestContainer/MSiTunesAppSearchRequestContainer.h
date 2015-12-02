//
//  MSiTunesAppSearchRequestContainer.h
//  MySearch
//
//  Created by Alexander Sviridov on 02/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSSerializationManager.h"

@interface MSiTunesAppSearchRequestContainer : NSObject <MSSerializationObjectProtocol>

@property NSString *term;
@property id country;
@property id media;
@property id entity;
@property id attribute;
@property id callback;
@property id limit;
@property id lang;
@property id version;
@property id requestExplicit;

@end
