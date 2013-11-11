//
//  RIDPlaceCompletionRequestHelperTests.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RIDPlaceCompletionRequestHelper.h"

@interface RIDPlaceCompletionRequestHelperTests : XCTestCase

@end

@implementation RIDPlaceCompletionRequestHelperTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testEmptyInputShouldReturnNilRequest
{
    NSURLRequest *request = [RIDPlaceCompletionRequestHelper urlRequestWithInput:@""];
    XCTAssertNil(request, @"Empty input should return nil request");
}

- (void)testNotEmptyInputShouldReturnNotNilRequest
{
    NSURLRequest *request = [RIDPlaceCompletionRequestHelper urlRequestWithInput:@"rastn"];
    XCTAssertNotNil(request, @"Not empty input should return not nil request");
}


-(void)testUrlString{
    RIDPlaceCompletionRequestHelper *helper = [[RIDPlaceCompletionRequestHelper alloc] init];
    NSString *strUrl = [helper performSelector:@selector(urlStringWithInput:) withObject:@"toto"];
    NSString *expecetUrl = @"http://www.meteo-france.mobi/ws/getLieux/toto.json";
    XCTAssertEqualObjects(strUrl, expecetUrl, @"Url with input toto should be [http://www.meteo-france.mobi/ws/getLieux/toto.json]");
}


-(void)testUrlStringWithSpace{
    RIDPlaceCompletionRequestHelper *helper = [[RIDPlaceCompletionRequestHelper alloc] init];
    NSString *strUrl = [helper performSelector:@selector(urlStringWithInput:) withObject:@"Saint martin des"];
    NSString *expecetUrl = @"http://www.meteo-france.mobi/ws/getLieux/Saint%20martin%20des.json";
    XCTAssertEqualObjects(strUrl, expecetUrl, @"Url with input [Saint martin des] should be [%@]", expecetUrl);
}

@end
