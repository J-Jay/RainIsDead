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

@interface  RIDPlace ( RIDPlaceRainHelper )
-(BOOL)isDataUpToDate;
@end


@interface  RIDRainPeriod (RIDPlaceRainHelper)
+(instancetype)rainPeriodWithDictionary:(NSDictionary *)json;
@end


@implementation RIDPlaceRainHelper{
    NSURLSession *_urlSession;
    NSMutableSet *_refreshingPlaces;
}

- (instancetype)init
{
    if (self = [super init]) {
        _refreshingPlaces = [[NSMutableSet alloc] initWithCapacity:10];
        _urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue currentQueue]];
    }
    return self;
}

-(void)updateRainInfoForPlaces:(NSOrderedSet *)places{
    [places enumerateObjectsUsingBlock:^(RIDPlace *place, NSUInteger idx, BOOL *stop) {
        [self updateRainInfoForPlace:place];
    }];
}

-(void)updateRainInfoForPlace:(RIDPlace *)place{

    if (!place.couvertPluie){
        [self sendStatusNotifications];
        return;
    }
    
    if (place.isDataUpToDate ) {
        [self sendStatusNotifications];
        return;
    }
    
    if ([_refreshingPlaces containsObject:place.indicatif]) {
        [self sendStatusNotifications];
        return;
    }
    
    [_refreshingPlaces addObject:place.indicatif];
    
    NSURLRequest *request = [RIDPlaceRainRequestHelper urlRequestWithPlace:place];
    
    NSURLSessionDataTask *sessionDataTask = [_urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSDictionary *jsonDico = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray  *intervalles = [[jsonDico objectForKey:@"result"] objectForKey:@"intervalles"];
        NSMutableArray *periodes = [[NSMutableArray alloc] initWithCapacity:[intervalles count]];
        for (NSDictionary *intervalle in intervalles) {
            [periodes addObject:[RIDRainPeriod rainPeriodWithDictionary:intervalle]];
        }
        place.rainPeriods = [NSArray arrayWithArray:periodes];
        place.lastUpdate = [NSDate timeIntervalSinceReferenceDate];
        [_refreshingPlaces removeObject:place.indicatif];
        [self sendStatusNotifications];
    }];
    [sessionDataTask resume];
    [self sendStatusNotifications];
}

-(void)sendStatusNotifications{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RIDPlaceRainHelperDidUpdateStatus" object:self userInfo:@{@"RIDPlaceRainHelperRequestCount":@([_refreshingPlaces count])}];
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

@implementation  RIDPlace ( RIDPlaceRainHelper )

#define uptodateLimit 20
-(BOOL)isDataUpToDate{
    return ( [self.rainPeriods count] > 0 && [NSDate timeIntervalSinceReferenceDate] - self.lastUpdate < uptodateLimit );
}

@end
