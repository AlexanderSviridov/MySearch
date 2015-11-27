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
    for ( NSString *mappingKey in mappingDict )
    {
        NSString *representationKey = mappingDict[mappingKey];
        id representationValue = representation[representationKey];
        NSValueTransformer *transformer = [contrainerClass msSerializationTransformerForKey:mappingKey];
        if ( !transformer )
        {
            [result setValue:representationValue forKey:mappingKey];
            continue;
        }
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
//    Class<MSSerializationObjectProtocol> objClass = [object class];
//    
//    NSDictionary *mapping = [objClass msSerializationMapping];
    
    return nil;
}

@end
