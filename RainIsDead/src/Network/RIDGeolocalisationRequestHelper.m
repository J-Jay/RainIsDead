//
//  RIDGeolocalisationRequestHelper.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 17/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import "RIDGeolocalisationRequestHelper.h"


@implementation RIDGeolocalisationRequestHelper


-(NSString *)urlStringWithCoordinate:(CLLocationCoordinate2D)coordinate{
    return [NSString stringWithFormat:@"http://services.gisgraphy.com/geoloc/search?format=JSON&lat=%.5f&lng=%.5f&placetype=City", coordinate.latitude, coordinate.longitude];
}

+(NSURLRequest *)urlRequestWithCoordinate:(CLLocationCoordinate2D)coordinate{
    RIDGeolocalisationRequestHelper *helper = [[RIDGeolocalisationRequestHelper alloc] init];
    NSString *urlStr = [helper urlStringWithCoordinate:coordinate];
    return [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
}

@end
