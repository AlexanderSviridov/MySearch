//
//  MSPromiseTest.m
//  MySearch
//
//  Created by Alexander Sviridov on 30/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MSPromise.h"

@interface MSPromiseTest : XCTestCase

@end

@implementation MSPromiseTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreation
{
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    MSPromise *newPromise = [MSPromise newPromise:^MSPromiseDisposable(MSPromiseFullfillBlock fullfill, MSPromiseRejectBclock reject) {
        fullfill(@2);
        return nil;
    }];
    [[newPromise then:^id(NSNumber *value) {
        XCTAssertEqual(value, @2);
        return nil;
    }] then:^MSPromise *(id value) {
        XCTAssertEqual(value, @2 );
        [expectation fulfill];
        return nil;
    }];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error);
    }];
}

@end
