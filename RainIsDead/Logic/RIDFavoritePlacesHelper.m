//
//  RIDFavoritePlacesHelper.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 14/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import "RIDFavoritePlacesHelper.h"
#import "RIDPlaceRainHelper.h"

NSString * const RIDFavoritePlacesHelperDidSave = @"RIDFavoritePlacesHelperDidSave";

@implementation RIDFavoritePlacesHelper{
    NSMutableOrderedSet *_places;
    NSTimer *_updateTimer;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSString *)favoritesArchiveFile{
    NSArray *writablePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [writablePaths lastObject];
    NSString *archiveFile = [documentsPath stringByAppendingPathComponent:@"places.data"];
    return archiveFile;
}

-(void)saveFavorites{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_places];
    [data writeToFile:[self favoritesArchiveFile] atomically:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:RIDFavoritePlacesHelperDidSave object:self];
}

-(void)loadFavorites{
    NSData *data = [NSData dataWithContentsOfFile:[self favoritesArchiveFile]];
    if (data!=nil) {
        _places = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    if (_places==nil) {
        _places = [NSMutableOrderedSet orderedSet];
    }
    
}

-(id)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(favoritePlacesHelperDidSave:) name:RIDFavoritePlacesHelperDidSave object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        [self loadFavorites];
        _updateTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(updateData:) userInfo:nil repeats:YES];
    }
    return self;
}

-(NSUInteger)placesCount{
    return [_places count];
}

-(RIDPlace *)placeAtIndex:(NSUInteger)index{
    RIDPlace *place = [_places objectAtIndex:index];
    [place updateRainInfos];
    return place;
}

-(void)addPlace:(RIDPlace *)aPlace{
    [_places addObject:aPlace];
    [self saveFavorites];
}

-(void)removePlaceAtIndex:(NSUInteger)index{
    [_places removeObjectAtIndex:index];
    [self saveFavorites];
}

-(void)favoritePlacesHelperDidSave:(NSNotification *)notif{
    if ([notif object] != self) {
        [self loadFavorites];
    }
}

-(void)applicationDidEnterBackground:(NSNotification *)notif{
    [_updateTimer invalidate];
    _updateTimer = nil;
}

-(void)applicationWillEnterForeground:(NSNotification *)notif{
    [_updateTimer invalidate];
    _updateTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(updateData:) userInfo:nil repeats:YES];
    [[_places array] makeObjectsPerformSelector:@selector(updateRainInfos) withObject:_updateTimer];
}

-(void)updateData:(NSTimer *)timer{
    [[_places array] makeObjectsPerformSelector:@selector(updateRainInfos)];
}

@end
