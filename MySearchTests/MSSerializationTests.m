//
//  MSSerializationTests.m
//  MySearch
//
//  Created by Alexander Sviridov on 03/12/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MSiTunesSearchResponceContainer.h"
#import "MSiTunesSearchResponceEntityContainer.h"
#import "MSSerializationManager.h"
#import "NSArray+MSLinqExtension.h"

@interface MSSerializationTests : XCTestCase

@end

@implementation MSSerializationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testSerialization
{
    NSDictionary *dic =  @{
        @"resultCount":@2,
        @"results":@[
                @{
                    @"wrapperType": @"track",
                    @"kind": @"song",
                    @"artistId": @909253,
                    @"collectionId": @879716730,
                    @"trackId": @879716742,
                    @"artistName": @"Jack Johnson"
                    },
                @{
                    @"wrapperType": @"track",
                    @"kind": @"song",
                    @"artistId": @909253,
                    @"collectionId": @879716730,
                    @"trackId": @879716742,
                    @"artistName": @"Jack Johnson"
                    },
                ]
    };
    MSiTunesSearchResponceContainer *serializedObject = [MSSerializationManager serializedObjectFromRepresentation:dic class:[MSiTunesSearchResponceContainer class]];
    XCTAssert([serializedObject isKindOfClass:[MSiTunesSearchResponceContainer class]]);
    XCTAssert([serializedObject.results isKindOfClass:[NSArray class]]);
    XCTAssertEqual(serializedObject.resultCount, 2);
    XCTAssertEqual(serializedObject.results.count, 2);
    for ( MSiTunesSearchResponceEntityContainer *entity in serializedObject.results )
    {
        XCTAssert([entity isKindOfClass:[MSiTunesSearchResponceEntityContainer class]]);
        XCTAssertEqual(entity.artistId, 909253);
        XCTAssertEqual(entity.collectionId, 879716730);
        XCTAssertEqual(entity.trackId, 879716742);
        XCTAssert([entity.wrapperType isEqualToString:@"track"]);
        XCTAssert([entity.kind isEqualToString:@"song"]);
        XCTAssert([entity.artistName isEqualToString:@"Jack Johnson"]);
    }
}

- (void)testReverseSerialization
{
    MSiTunesSearchResponceContainer *container = [MSiTunesSearchResponceContainer new];
    container.resultCount = 2;
    container.results = [NSArray arrayWithBlock:^id{
        MSiTunesSearchResponceEntityContainer *entity = [MSiTunesSearchResponceEntityContainer new];
        entity.artistId = 909253;
        entity.collectionId = 879716730;
        entity.trackId = 879716742;
        entity.wrapperType = @"track";
        entity.kind = @"song";
        entity.artistName = @"Jack Johnson";
        return entity;
    } count:2];
    NSDictionary *serializedObject = [MSSerializationManager serializeObjectIntoRepresentationFromObject:container];
    XCTAssert([serializedObject isKindOfClass:[NSDictionary class]]);
    XCTAssert([serializedObject[@"resultCount"] isEqualToNumber:@2]);
    NSArray *results = serializedObject[@"results"];
    XCTAssert([results isKindOfClass:[NSArray class]]);
    XCTAssertEqual(results.count, 2);
    for ( NSDictionary *dic in results )
    {
        XCTAssert([dic isKindOfClass:[NSDictionary class]]);
        XCTAssert([dic[@"wrapperType"] isEqualToString:@"track"]);
        XCTAssert([dic[@"kind"] isEqualToString:@"song"]);
        XCTAssert([dic[@"artistId"] isEqualToNumber:@909253]);
        XCTAssert([dic[@"collectionId"] isEqualToNumber:@879716730]);
        XCTAssert([dic[@"trackId"] isEqualToNumber:@879716742]);
        XCTAssert([dic[@"artistName"] isEqualToString:@"Jack Johnson"]);
    }
}

@end
