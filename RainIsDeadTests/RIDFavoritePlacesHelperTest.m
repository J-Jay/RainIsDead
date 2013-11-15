//
//  RIDFavoritePlacesHelperTest.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 14/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RIDFavoritePlacesHelper.h"

@interface RIDFavoritePlacesHelperTest : XCTestCase

@end

@implementation RIDFavoritePlacesHelperTest

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

-(RIDPlace *)getNewPlaceWithName:(NSString *)name indicatif:(NSString *)indicatif{
    RIDPlace *place = [[RIDPlace alloc] init];
    place.nom = name;
    place.indicatif = indicatif;;
    place.codePostal = @"67890";
    place.couvertPluie = YES;
    return place;
}

-(void)cleanArchive{
    RIDFavoritePlacesHelper *helper = [[RIDFavoritePlacesHelper alloc] init];
    NSString *archiveFile = [helper valueForKey:@"favoritesArchiveFile"];
    [[NSFileManager defaultManager] removeItemAtPath:archiveFile error:nil];
    helper = nil;
}

-(void)testPlaceCountShouldReturn_0{
    [self cleanArchive];
    RIDFavoritePlacesHelper *helper = [[RIDFavoritePlacesHelper alloc] init];
    XCTAssertEqual([helper  placesCount], (NSUInteger)0, @"place count should be 0");
    helper = nil;
}

-(void)testAddPlaceShouldAddPlace{
    [self cleanArchive];
    RIDFavoritePlacesHelper *helper = [[RIDFavoritePlacesHelper alloc] init];
    RIDPlace *place = [self getNewPlaceWithName:@"place name" indicatif:@"12345"];
    [helper addPlace:place];
    
    RIDPlace *addedPlace = [helper placeAtIndex:0];
    XCTAssertNotNil(addedPlace, @"newly added place in favorite should not be nil");
    XCTAssertEqualObjects(place, addedPlace, @"newly added place in favorite should be in favorite");
    helper = nil;
}

-(void)testArchive{
    [self cleanArchive];
    
    RIDFavoritePlacesHelper *helper = [[RIDFavoritePlacesHelper alloc] init];
    [helper addPlace:[self getNewPlaceWithName:@"place name" indicatif:@"12345"]];

    RIDFavoritePlacesHelper *helper2 = [[RIDFavoritePlacesHelper alloc] init];
    XCTAssertEqual([helper2  placesCount], (NSUInteger)1, @"place count should be 1");
    helper = nil;
    helper2 = nil;
}

-(void)testAddPlaceOnArchivedPlaces{
    
    [self cleanArchive];
    
    RIDFavoritePlacesHelper *helper1 = [[RIDFavoritePlacesHelper alloc] init];
    RIDPlace *place1 = [self getNewPlaceWithName:@"place name 1" indicatif:@"12345"];
    [helper1 addPlace:place1];

    RIDFavoritePlacesHelper *helper2 = [[RIDFavoritePlacesHelper alloc] init];
    RIDPlace *place2 = [self getNewPlaceWithName:@"place name 2" indicatif:@"123456"];
    [helper2 addPlace:place2];
    
    RIDFavoritePlacesHelper *helper3 = [[RIDFavoritePlacesHelper alloc] init];
    RIDPlace *addedPlace1 = [helper3 placeAtIndex:0];
    RIDPlace *addedPlace2 = [helper3 placeAtIndex:1];
    XCTAssertNotNil(addedPlace1, @"newly added place in favorite should not be nil");
    XCTAssertNotNil(addedPlace2, @"newly added place in favorite should not be nil");
    XCTAssertEqualObjects(addedPlace1.nom, @"place name 1", @"newly added place 1 nom in favorite should be [place name 1]");
    XCTAssertEqualObjects(addedPlace2.nom, @"place name 2", @"newly added place 1 nom in favorite should be [place name 2]");

    helper1 = nil;
    helper2 = nil;
    helper3 = nil;
}

-(void)testReloadOnAddPlaceOnAnOtherHelper{
    
    [self cleanArchive];
    
    RIDFavoritePlacesHelper *helper1 = [[RIDFavoritePlacesHelper alloc] init];
    RIDPlace *place1 = [self getNewPlaceWithName:@"place name 1" indicatif:@"12345"];
    [helper1 addPlace:place1];
    XCTAssertEqual([helper1  placesCount], (NSUInteger)1, @"place count should be 1");

    
    RIDFavoritePlacesHelper *helper2 = [[RIDFavoritePlacesHelper alloc] init];
    RIDPlace *place2 = [self getNewPlaceWithName:@"place name 2" indicatif:@"123456"];
    [helper2 addPlace:place2];

    XCTAssertEqual([helper1  placesCount], (NSUInteger)2, @"place count should be 2");
    XCTAssertEqual([helper2  placesCount], (NSUInteger)2, @"place count should be 2");

    helper1 = nil;
    helper2 = nil;
}

-(void)testMove{
    
    [self cleanArchive];

    RIDFavoritePlacesHelper *helper1 = [[RIDFavoritePlacesHelper alloc] init];
    RIDPlace *place1 = [self getNewPlaceWithName:@"place name 1" indicatif:@"12345"];
    [helper1 addPlace:place1];
    RIDPlace *place2 = [self getNewPlaceWithName:@"place name 2" indicatif:@"123456"];
    [helper1 addPlace:place2];
    RIDPlace *place3 = [self getNewPlaceWithName:@"place name 3" indicatif:@"1234567"];
    [helper1 addPlace:place3];
    
    XCTAssertEqual(place1, [helper1 placeAtIndex:0], @"");
    XCTAssertEqual(place2, [helper1 placeAtIndex:1], @"");
    XCTAssertEqual(place3, [helper1 placeAtIndex:2], @"");
    
    [helper1 movePlaceAtIndex:0 toIndex:1];
    XCTAssertEqual(place2, [helper1 placeAtIndex:0], @"");
    XCTAssertEqual(place1, [helper1 placeAtIndex:1], @"");
    XCTAssertEqual(place3, [helper1 placeAtIndex:2], @"");

    [helper1 movePlaceAtIndex:1 toIndex:2];
    XCTAssertEqual(place2, [helper1 placeAtIndex:0], @"");
    XCTAssertEqual(place3, [helper1 placeAtIndex:1], @"");
    XCTAssertEqual(place1, [helper1 placeAtIndex:2], @"");

    [helper1 movePlaceAtIndex:0 toIndex:2];
    XCTAssertEqual(place3, [helper1 placeAtIndex:0], @"");
    XCTAssertEqual(place1, [helper1 placeAtIndex:1], @"");
    XCTAssertEqual(place2, [helper1 placeAtIndex:2], @"");

    helper1 = nil;
}

@end
