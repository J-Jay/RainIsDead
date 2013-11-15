//
//  RIDFavoritePlacesHelper.h
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 14/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RIDPlace.h"

@interface RIDFavoritePlacesHelper : NSObject

-(NSUInteger)placesCount;
-(RIDPlace *)placeAtIndex:(NSUInteger)index;
-(void)addPlace:(RIDPlace *)aPlace;
-(void)removePlaceAtIndex:(NSUInteger)index;
-(void)movePlaceAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

-(void)updateAllPlaces;

@end
