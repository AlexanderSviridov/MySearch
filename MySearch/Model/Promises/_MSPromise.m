//
//  MSPromise.m
//  MySearch
//
//  Created by Alexander Sviridov on 30/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "_MSPromise.h"

@interface _MSPromise ()

@property _MSPromise *prevPromise;
@property (weak) _MSPromise *nextPromise;
@property (copy) MSPromiseDisposable disposable;

@end

@implementation _MSPromise
{
}

+ (_MSPromise *)newPromise:(MSPromiseDisposable (^)(MSPromiseFullfillBlock, MSPromiseRejectBclock))block
{
    _MSPromise *resultPromise = [_MSPromise new];
    __weak _MSPromise *_self_weak;
    resultPromise.disposable = block(^(id fullfil){
        _MSPromise *_self = _self_weak;
        if ( _self.nextPromise )
            [_self.nextPromise prevPromiseHasFullfil:fullfil];
    }, ^(NSError *reject){
        _MSPromise *_self = _self_weak;
        if ( _self.nextPromise )
            [_self.nextPromise prevPromiseHasReject:reject];
    });
    
    return resultPromise;
}

- (_MSPromise *)then:(MSPromiseNextBlock)thenBlock
{
    _MSPromise *nextPromise = [_MSPromise new];
    nextPromise.prevPromise = self;
    self.nextPromise = nextPromise;
    return nextPromise;
}

- (_MSPromise *)thenOnBackground:(MSPromiseNextBlock)thenBlock
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
