//
//  RIDPlaceRainHelper.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import "RIDPlaceRainHelper.h"
#import "RIDPlaceRainRequestHelper.h"
#import "RIDRainPeriod.h"


@interface  RIDRainPeriod (RIDPlaceRainHelper)
+(instancetype)rainPeriodWithDictionary:(NSDictionary *)json;
@end


@implementation RIDPlaceRainHelper


+(void)updateRainInfoForPlace:(RIDPlace *)aPlace{
    
    NSURLRequest *request = [RIDPlaceRainRequestHelper urlRequestWithPlace:aPlace];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *jsonDico = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray  *intervalles = [[jsonDico objectForKey:@"result"] objectForKey:@"intervalles"];
        NSMutableArray *periodes = [[NSMutableArray alloc] initWithCapacity:[intervalles count]];
        for (NSDictionary *intervalle in intervalles) {
            [periodes addObject:[RIDRainPeriod rainPeriodWithDictionary:intervalle]];
        }
        aPlace.rainPeriods = [NSArray arrayWithArray:periodes];
    }];

}

@end


@implementation RIDRainPeriod (RIDPlaceRainHelper)

+(instancetype)rainPeriodWithDictionary:(NSDictionary *)json{
    RIDRainPeriod *rainPeriod = [[RIDRainPeriod alloc] init];
    NSTimeInterval timestamp = [[json objectForKey:@"date"] doubleValue] / 1000.0f;
    rainPeriod.startDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    rainPeriod.type = [[json objectForKey:@"value"] integerValue];
    return  rainPeriod;
}

@end