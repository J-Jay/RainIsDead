//
//  RIDPlaceRainRequestHelper.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import "RIDPlaceRainRequestHelper.h"

@implementation RIDPlaceRainRequestHelper

//    http://www.meteo-france.mobi/ws/getPluie/4410900.json

+(NSURLRequest *)urlRequestWithPlace:(RIDPlace *)place{

    NSString *strRequest = [NSString stringWithFormat:@"http://www.meteo-france.mobi/ws/getPluie/%@0.json", place.indicatif];
    return [NSURLRequest requestWithURL:[NSURL URLWithString:strRequest]];
}

@end
