//
//  RIDPlaceRainHelper.h
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RIDPlace.h"

@interface RIDPlaceRainHelper : NSObject

-(void)updateRainInfoForPlace:(RIDPlace *)place;
-(void)updateRainInfoForPlaces:(NSOrderedSet *)places;

@end


