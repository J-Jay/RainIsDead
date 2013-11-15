//
//  RIDGeolocalisationRequestHelperTest.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 17/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RIDGeolocalisationRequestHelper.h"

@interface RIDGeolocalisationRequestHelperTest : XCTestCase

@end

@implementation RIDGeolocalisationRequestHelperTest

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

- (void)testUrlRequestWithCoordinate
{
    NSURLRequest *request = [RIDGeolocalisationRequestHelper urlRequestWithCoordinate:(CLLocationCoordinate2D){48.5164884, 2.331546}];
    NSString *absoluteString = [[request URL] absoluteString];
    NSString *expectedUrlStr = @"http://services.gisgraphy.com/geoloc/search?format=JSON&lat=48.51649&lng=2.33155&placetype=City";
    XCTAssertEqualObjects(absoluteString, expectedUrlStr, @"Url string should be [services.gisgraphy.com/geoloc/search?format=JSON&lat=48.51649&lng=2.33155&placetype=City]");
}

@end
