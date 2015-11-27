//
//  MSSerializationValueTransformer.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol MSSerializationObjectProtocol;

@interface MSSerializationValueTransformer<__covariant FromType, __covariant DestinationType> : NSValueTransformer
{
    DestinationType (^_forwardBlock)( FromType );
    FromType (^_reverseBlock)( DestinationType );
}

+ (MSSerializationValueTransformer *)transformerWithBlock:(DestinationType(^)(FromType))block reverseBlock:(FromType(^)(DestinationType))reverseBlock;
+ (MSSerializationValueTransformer<NSDictionary *, id> *)transformerForSerializedObjecOfClass:(Class<MSSerializationObjectProtocol>)serializedClass;
+ (MSSerializationValueTransformer<NSArray *, NSArray *> *)transformerForArraySerializedObjectsOfClass:(Class<MSSerializationObjectProtocol>)serializedArrayClass;

#pragma mark -

- (DestinationType)transformedValue:(FromType)value;
- (FromType)reverseTransformedValue:(DestinationType)value;

@end
