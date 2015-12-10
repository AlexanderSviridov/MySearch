//
//  MSSerializationManager.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSSerializationManager.h"
#import "NSArray+MSLinqExtension.h"

@implementation MSSerializationManager

+ (id)serializedObjectFromRepresentation:(NSDictionary *)representation class:(__unsafe_unretained Class<MSSerializationObjectProtocol>)contrainerClass
{
    NSDictionary<NSString *, NSString *> *mappingDict = [contrainerClass msSerializationMapping];
    id result = [(Class)contrainerClass new];
    for ( NSString *mappingKey in mappingDict ) {
        NSString *representationKey = mappingDict[mappingKey];
        id representationValue = representation[representationKey];
        NSValueTransformer *transformer = [contrainerClass msSerializationTransformerForKey:mappingKey];
        id serializedValue = nil;
        if ( !transformer )
            serializedValue = representationValue;
        else
            serializedValue = [transformer transformedValue:representationValue];
        if ( serializedValue )
            [result setValue:serializedValue forKey:mappingKey];
    }
    return result;
}

+ (NSArray *)serializedObjectFromArrayRepresentation:(NSArray *)arrayRepresentation class:(__unsafe_unretained Class<MSSerializationObjectProtocol>)containerClass
{
    return [arrayRepresentation linq_map:^id(id oldValue) {
        return [MSSerializationManager serializedObjectFromRepresentation:oldValue class:containerClass];
    }];
}

+ (id)serializeObjectIntoRepresentationFromObject:(id)object
{
    Class<MSSerializationObjectProtocol> objClass = [object class];

    if ( [object isKindOfClass:[NSArray class]] )
        return [(NSArray *)object linq_map:^id(id oldValue) {
            return [self serializeObjectIntoRepresentationFromObject:oldValue];
        }];
    
    if ( [(Class)objClass respondsToSelector:@selector(msSerializationMapping)] && [(Class)objClass respondsToSelector:@selector(msSerializationTransformerForKey:)] ) {
        NSDictionary<NSString *, NSString *> *mapping = [objClass msSerializationMapping];
        NSMutableDictionary *resultDictionary = [NSMutableDictionary new];
        for ( NSString *key in mapping.allKeys ) {
            NSString *value = mapping[key];
            id objectValue = [object valueForKey:key];
            NSValueTransformer *transformer = [objClass msSerializationTransformerForKey:key];
            id resultValue = nil;
            if ( transformer )
                resultValue = [transformer reverseTransformedValue:objectValue];
            else
                resultValue = [self serializeObjectIntoRepresentationFromObject:objectValue];
            if ( resultValue )
                [resultDictionary setObject:resultValue forKey:value];
        }
        return [NSDictionary dictionaryWithDictionary:resultDictionary];
    }
    
    return object;
}

@end
