//
//  RIDRainPeriod.h
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RIDRainPeriod : NSObject
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, assign) NSInteger type;
@end
