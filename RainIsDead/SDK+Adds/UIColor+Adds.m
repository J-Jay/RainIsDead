//
//  UIColor+Adds.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 14/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import "UIColor+Adds.h"

@implementation UIColor (Adds)

+(UIColor *)colorForPeriod:(RIDRainPeriod *)period{
    
    if (period.type == RIDRainPeriodTypeNoData) {
        return [UIColor noRainDataAvailableColor];
    
    } else if (period.type == RIDRainPeriodTypeNoRain) {
        return [UIColor noRainColor];
    
    } else if (period.type == RIDRainPeriodTypeSmallRain) {
        return [UIColor smallRainColor];
    
    } else if (period.type == RIDRainPeriodTypeRain) {
        return [UIColor rainColor];
    
    } else if (period.type == RIDRainPeriodTypeBigRain) {
        return [UIColor bigRainColor];
    
    }
    return [UIColor clearColor];
}

+(UIColor *)noRainDataAvailableColor{
    return [UIColor clearColor];
}

+(UIColor *)noRainColor{
    return [UIColor colorWithRed:76.0f/255.0f green:217.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
}

+(UIColor *)smallRainColor{
    return [UIColor colorWithRed:52.0f/255.0f green:170.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
}

+(UIColor *)rainColor{
    return [UIColor colorWithRed:8.0f/255.0f green:86.0f/255.0f blue:214.0f/255.0f alpha:1.0f];
}

+(UIColor *)bigRainColor{
    return [UIColor colorWithRed:255.0f/255.0f green:45.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
}

@end
