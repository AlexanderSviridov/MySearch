//
//  MSGithubOwnerContainer.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSSerializationManager.h"

@interface MSGithubOwnerContainer : NSObject<MSSerializationObjectProtocol>

@property id login;
@property id container_id;
@property id avatar_url;
@property id gravatar_id;
@property id url;
@property id html_url;
@property id followers_url;
@property id following_url;
@property id gists_url;
@property id starred_url;
@property id subscriptions_url;
@property id organizations_url;
@property id repos_url;
@property id events_url;
@property id received_events_url;
@property id type;
@property id site_admin;

@end
