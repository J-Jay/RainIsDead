//
//  UIColor+Adds.h
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 14/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RIDRainPeriod.h"

@interface UIColor (Adds)

+(UIColor *)colorForPeriod:(RIDRainPeriod *)period;

+(UIColor *)noRainDataAvailableColor;
+(UIColor *)noRainColor;
+(UIColor *)smallRainColor;
+(UIColor *)rainColor;
+(UIColor *)bigRainColor;

@end
