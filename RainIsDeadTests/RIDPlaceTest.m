//
//  RIDPlaceTest.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RIDPlace.h"

@interface RIDPlaceTest : XCTestCase

@end

@implementation RIDPlaceTest

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

- (void) testArchiver {
    RIDPlace *place = [[RIDPlace alloc] init];
    place.nom = @"place name";
    place.indicatif = @"12345";
    place.codePostal = @"67890";
    place.couvertPluie = YES;

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:place];
    RIDPlace *archivedPlace = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    XCTAssertNotNil(archivedPlace, @"unarchived place should not be nil");
    XCTAssertEqualObjects(archivedPlace.nom, @"place name", @"unarchived place name should be [place name]");
    XCTAssertEqualObjects(archivedPlace.indicatif, @"12345", @"unarchived place indicatif should be [12345]");
    XCTAssertEqualObjects(archivedPlace.codePostal, @"67890", @"unarchived place codePostal should be [67890]");
    XCTAssertEqual(archivedPlace.couvertPluie, YES, @"unarchived place couvertPluie should be YES");
}

-(void)testEquals{
    RIDPlace *place1 = [[RIDPlace alloc] init];
    place1.indicatif = @"1234";
    
    RIDPlace *place2 = [[RIDPlace alloc] init];
    place2.indicatif = @"1234";
    
    XCTAssertEqualObjects(place1, place2, @"place1 should equals place2");
}

-(void)testNotEquals{
    RIDPlace *place1 = [[RIDPlace alloc] init];
    place1.indicatif = @"1234";
    
    RIDPlace *place2 = [[RIDPlace alloc] init];
    place2.indicatif = @"1243";
    
    XCTAssertNotEqualObjects(place1, place2, @"place1 should not equals place2");
}

@end
