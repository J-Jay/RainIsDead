//
//  RIDGeolocalisationRequestHelper.h
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 17/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface RIDGeolocalisationRequestHelper : NSObject

+(NSURLRequest *)urlRequestWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
