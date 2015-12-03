//
//  MSiTunesSearchResponceEntityContainer.h
//  MySearch
//
//  Created by Alexander Sviridov on 02/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSSerializationManager.h"
#import "MSSearchResultCellViewModel.h"

@interface MSiTunesSearchResponceEntityContainer : NSObject <MSSerializationObjectProtocol, MSSearchResultCellViewModel>

@property id wrapperType;
@property id kind;
@property NSInteger artistId;
@property NSInteger collectionId;
@property NSInteger trackId;
@property NSString *artistName;
@property id collectionName;
@property id trackName;
@property id collectionCensoredName;
@property id trackCensoredName;
@property id artistViewUrl;
@property id collectionViewUrl;
@property id trackViewUrl;
@property id previewUrl;
@property id artworkUrl30;
@property id artworkUrl60;
@property id artworkUrl100;
@property id collectionPrice;
@property id trackPrice;
@property id releaseDate;
@property id collectionExplicitness;
@property id trackExplicitness;
@property id discCount;
@property id discNumber;
@property id trackCount;
@property id trackNumber;
@property id trackTimeMillis;
@property id country;
@property id currency;
@property id primaryGenreName;
@property id radioStationUrl;
@property id isStreamable;

@end
