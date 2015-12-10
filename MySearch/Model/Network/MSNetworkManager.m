//
//  MSNetworkManager.m
//  MySearch
//
//  Created by Alexander Sviridov on 02/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSNetworkManager.h"

@implementation MSNetworkManager

- (MSPromise<NSData *> *)getDataWithURL:(NSURL *)url
{
    return [MSPromise newPromise:^MSPromiseDisposable(MSPromiseFullfillBlock fullfil, MSPromiseRejectBclock reject) {
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if ( !data ) {
                reject(error);
                return;
            }
            fullfil( data );
        }];
        [dataTask resume];
        return ^{
            [dataTask cancel];
        };
    }];
}

- (MSPromise *)getJSONObjectWithURL:(NSURL *)url
{
    return [[self getDataWithURL:url] then:^id(NSData *data) {
        NSError *__autoreleasing err;
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        if ( err )
            return err;
        return result;
    }];
}

@end
