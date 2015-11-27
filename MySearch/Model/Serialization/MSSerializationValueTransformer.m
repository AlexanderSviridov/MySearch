//
//  MSSerializationValueTransformer.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSSerializationValueTransformer.h"

#import "NSArray+MSLinqExtension.h"
#import "MSSerializationManager.h"

@interface MSSerializationValueTransformer<FromType, DestinationType> ()

@property (copy) DestinationType (^forwardBlock)( FromType );
@property (copy) FromType (^reverseBlock)(DestinationType);

@end

@implementation MSSerializationValueTransformer

@synthesize forwardBlock = _forwardBlock, reverseBlock = _reverseBlock;

+ (instancetype)transformerWithBlock:(id (^)(id))block reverseBlock:(id (^)(id))reverseBlock
{
    MSSerializationValueTransformer *result = [self new];
    result.forwardBlock = block;
    result.reverseBlock = reverseBlock;
    return result;
}

+ (instancetype)transformerForSerializedObjecOfClass:(Class<MSSerializationObjectProtocol>)serializedClass
{
    MSSerializationValueTransformer<NSDictionary *, id> *result = [self new];
    result.forwardBlock = ^id(NSDictionary *value ) {
        return [MSSerializationManager serializedObjectFromRepresentation:value class:serializedClass];
    };
    result.reverseBlock = ^id(id value ) {
        return [MSSerializationManager serializeObjectIntoRepresentationFromObject:value];
    };
    return result;
}

+ (instancetype)transformerForArraySerializedObjectsOfClass:(Class<MSSerializationObjectProtocol>)serializedArrayClass
{
    MSSerializationValueTransformer<NSArray *, NSArray *> *result = [self new];
    result.forwardBlock = ^NSArray*(NSArray *value ) {
        return [MSSerializationManager serializedObjectFromArrayRepresentation:value class:serializedArrayClass];
    };
    result.reverseBlock = ^NSArray*(NSArray *value ) {
        return [MSSerializationManager serializeObjectIntoRepresentationFromObject:value];
    };
    return result;
}

#pragma mark Transformer methods

- (id)transformedValue:(id)value
{
    if ( self.forwardBlock )
        return self.forwardBlock( value );
    return nil;
}

- (id)reverseTransformedValue:(id)value
{
    if ( self.reverseBlock )
        return self.reverseBlock( value );
    return nil;
}

@end
