//
//  RIDPlaceCompletionRequest.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import "RIDPlaceCompletionRequestHelper.h"

@implementation RIDPlaceCompletionRequestHelper


-(NSString *)urlStringWithInput:(NSString *)input{
    NSString *percentEscapedInput = [input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"http://www.meteo-france.mobi/ws/getLieux/%@.json", percentEscapedInput];
}

+(NSURLRequest *)urlRequestWithInput:(NSString *)inputString{
    if (inputString==nil || [inputString length]==0){
        return nil;
    }
    
    RIDPlaceCompletionRequestHelper *requestHelper = [[RIDPlaceCompletionRequestHelper alloc] init];
    return [NSURLRequest requestWithURL:[NSURL URLWithString:[requestHelper urlStringWithInput:inputString]]];
}

@end
