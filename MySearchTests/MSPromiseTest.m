//
//  MSPromiseTest.m
//  MySearch
//
//  Created by Alexander Sviridov on 30/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "_MSPromise.h"

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
    [newPromise then:^id(NSNumber *value) {
        XCTAssertEqual(value, @2);
        [expectation fulfill];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
        XCTFail(@"");
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
