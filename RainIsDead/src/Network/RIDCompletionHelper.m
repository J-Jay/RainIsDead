//
//  RIDCompletionHelper.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import "RIDCompletionHelper.h"
#import "RIDPlaceCompletionRequestHelper.h"
#import "RIDPlace.h"

#define kResultKey @"result"
#define kFranceKey @"france"

@interface  RIDPlace(RIDCompletionHelper)
+(RIDPlace *)placeWithJson:(NSDictionary *)json;
@end


@implementation RIDCompletionHelper

-(NSArray *)placesWithJsonResponse:(NSData *)json error:(NSError **)error{
    
    NSDictionary *dico =  [NSJSONSerialization JSONObjectWithData:json options:0 error:error];
    NSArray *places = [[dico objectForKey:kResultKey] objectForKey:kFranceKey];
    NSMutableArray *mutplaces = [[NSMutableArray alloc] initWithCapacity:[places count]];
    for (NSDictionary *lcPlaceDico in places) {
        [mutplaces addObject:[RIDPlace placeWithJson:lcPlaceDico]];
    }
    return [NSArray arrayWithArray:mutplaces];
}

-(void)placesWithInput:(NSString *)input completionHandler:(void (^)(NSArray *places, NSError* connectionError))completion{

    NSURLRequest *request = [RIDPlaceCompletionRequestHelper urlRequestWithInput:input];
    if (request==nil) {
        completion(nil, nil);
        return;
    }
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode!=200 || connectionError!=nil) {
            completion(nil, connectionError);
        } else {
            NSError *error=nil;
            NSArray *places = [self placesWithJsonResponse:data error:&error];
            completion(places, error);
        }
    }];
    
}

@end

@implementation  RIDPlace(RIDCompletionHelper)

+(RIDPlace *)placeWithJson:(NSDictionary *)json{
    RIDPlace *place = [[RIDPlace alloc] init];
    place.indicatif = [json objectForKey:@"indicatif"];
    place.nom = [json objectForKey:@"nom"];
    place.codePostal = [json objectForKey:@"codePostal"];
    place.couvertPluie = [[json objectForKey:@"couvertPluie"] boolValue];
    return place;
}

@end
