//
//  MSSerializationManager.h
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSSerializationObjectProtocol <NSObject>

/**
 *  Mapping
 *  Will serialize only keys, thats located in mapping dict
 *
 *  @return Dictionary of resultObjectKey and value from representation
 */
+ (NSDictionary<NSString *, NSString *> *)msSerializationMapping;

/**
 *  Serialization Transformer
 *
 *  @param key mapping key
 *
 *  @return transformer for specific kind of data
 */
+ (NSValueTransformer *)msSerializationTransformerForKey:(NSString *)key;

@end

@interface MSSerializationManager : NSObject

+ (id)serializedObjectFromRepresentation:(NSDictionary *)representation class:(__unsafe_unretained Class<MSSerializationObjectProtocol>)contrainerClass;

+ (NSArray *)serializedObjectFromArrayRepresentation:(NSArray *)arrayRepresentation class:(__unsafe_unretained Class<MSSerializationObjectProtocol>)containerClass;

#warning reverse serializing not implemented
+ (id)serializeObjectIntoRepresentationFromObject:(id)object;

@end
