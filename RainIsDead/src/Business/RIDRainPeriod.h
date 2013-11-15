//
//  RIDRainPeriod.h
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RIDRainPeriodType) {
    RIDRainPeriodTypeNoData = 0,
    RIDRainPeriodTypeNoRain,
    RIDRainPeriodTypeSmallRain,
    RIDRainPeriodTypeRain,
    RIDRainPeriodTypeBigRain,
};

@interface RIDRainPeriod : NSObject
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, assign) RIDRainPeriodType type;
@end
