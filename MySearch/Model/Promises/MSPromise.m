//
//  MSPromise.m
//  MySearch
//
//  Created by Alexander Sviridov on 30/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSPromise.h"

@interface MSPromise ()

@property MSPromise *prevPromise;
@property (weak) MSPromise *nextPromise;
@property (copy) MSPromiseDisposable disposable;

@end

@implementation MSPromise
{
}

+ (MSPromise *)newPromise:(MSPromiseDisposable (^)(MSPromiseFullfillBlock, MSPromiseRejectBclock))block
{
    MSPromise *resultPromise = [MSPromise new];
    __weak MSPromise *_self_weak;
    resultPromise.disposable = block(^(id fullfil){
        MSPromise *_self = _self_weak;
        if ( _self.nextPromise )
            [_self.nextPromise prevPromiseHasFullfil:fullfil];
    }, ^(NSError *reject){
        MSPromise *_self = _self_weak;
        if ( _self.nextPromise )
            [_self.nextPromise prevPromiseHasReject:reject];
    });
    
    return resultPromise;
}

- (MSPromise *)then:(MSPromiseNextBlock)thenBlock
{
    MSPromise *nextPromise = [MSPromise new];
    nextPromise.prevPromise = self;
    self.nextPromise = nextPromise;
    return nextPromise;
}

- (MSPromise *)thenOnBackground:(MSPromiseNextBlock)thenBlock
{
    return nil;
}

- (void)cancel
{
    if ( _prevPromise )
        [_prevPromise cancel];
    if ( _disposable )
    {
        _disposable();
        _disposable = nil;
    }
}

#pragma mark - private

- (void)prevPromiseHasFullfil:(id)value
{
    
}

- (void)prevPromiseHasReject:(NSError *)err
{
    
}

//- (void)pre

@end
