//
//  MSiTunesSearchResponceEntityContainer.m
//  MySearch
//
//  Created by Alexander Sviridov on 02/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSiTunesSearchResponceEntityContainer.h"

@implementation MSiTunesSearchResponceEntityContainer

+ (NSDictionary<NSString *, NSString *> *)msSerializationMapping
{
    return @{
        @"wrapperType":@"wrapperType",
        @"kind":@"kind",
        @"artistId":@"artistId",
        @"collectionId":@"collectionId",
        @"trackId":@"trackId",
        @"artistName":@"artistName",
        @"collectionName":@"collectionName",
        @"trackName":@"trackName",
        @"collectionCensoredName":@"collectionCensoredName",
        @"trackCensoredName":@"trackCensoredName",
        @"artistViewUrl":@"artistViewUrl",
        @"collectionViewUrl":@"collectionViewUrl",
        @"trackViewUrl":@"trackViewUrl",
        @"previewUrl":@"previewUrl",
        @"artworkUrl30":@"artworkUrl30",
        @"artworkUrl60":@"artworkUrl60",
        @"artworkUrl100":@"artworkUrl100",
        @"collectionPrice":@"collectionPrice",
        @"trackPrice":@"trackPrice",
        @"releaseDate":@"releaseDate",
        @"collectionExplicitness":@"collectionExplicitness",
        @"trackExplicitness":@"trackExplicitness",
        @"discCount":@"discCount",
        @"discNumber":@"discNumber",
        @"trackCount":@"trackCount",
        @"trackNumber":@"trackNumber",
        @"trackTimeMillis":@"trackTimeMillis",
        @"country":@"country",
        @"currency":@"currency",
        @"primaryGenreName":@"primaryGenreName",
        @"radioStationUrl":@"radioStationUrl",
        @"isStreamable":@"isStreamable"
    };
}

+ (NSValueTransformer *)msSerializationTransformerForKey:(NSString *)key
{
    return nil;
}

- (NSString *)cellViewModelTitle
{
    return self.artistName;
}

- (NSString *)cellViewModelDetail
{
    return self.trackName;
}

- (NSURL *)cellViewModelImageURL
{
    return [NSURL URLWithString:self.artworkUrl100];
}

@end
