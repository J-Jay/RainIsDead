//
//  RIDRainView.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import "RIDRainView.h"
#import "RIDRainPeriod.h"


@interface RIDRainView()
@end

@implementation RIDRainView

static NSString *kvoContext = @"RIDRainViewKvoContext";

- (void)dealloc
{
    @try {
        [self removeObserver:self forKeyPath:@"place.rainPeriods"];
    }
    @catch (NSException *exception) {
        
    }
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self addObserver:self forKeyPath:@"place.rainPeriods" options:NSKeyValueObservingOptionInitial context:(__bridge void *)(kvoContext)];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    if ([self.subviews count] != ([self.place.rainPeriods count]-1) ) {
        [self reloadSubviews];
    }
    
    if ([self.subviews count]<2) {
        [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        return;
    }
    
    NSTimeInterval startTime = [[[self.place.rainPeriods firstObject] startDate] timeIntervalSince1970];
    NSTimeInterval endTime = [[[self.place.rainPeriods lastObject] startDate] timeIntervalSince1970];
    NSTimeInterval periodLength = endTime - startTime;
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    CGRect periodFrame = self.bounds;
    
    for (int i=0 ; i<[self.subviews count] ; i++) {
        NSTimeInterval curentPeriodStartTime = [[[self.place.rainPeriods objectAtIndex:i] startDate] timeIntervalSince1970];
        NSTimeInterval curentPeriodEndTime = [[[self.place.rainPeriods objectAtIndex:i+1] startDate] timeIntervalSince1970];
        NSTimeInterval curentPeriodLength = curentPeriodEndTime - curentPeriodStartTime;
        periodFrame.size.width = (viewWidth * curentPeriodLength / periodLength) - 1;
        
        RIDRainPeriod *period = [self.place.rainPeriods objectAtIndex:i];

        if (period.type == 0) {
            periodFrame.size.height = 0.0f;
        } else if (period.type == 1) {
            periodFrame.size.height = CGRectGetHeight(self.bounds) / 4.0f;
        } else if (period.type == 2) {
            periodFrame.size.height = 2.0f * CGRectGetHeight(self.bounds) / 4.0f;
        } else if (period.type == 3) {
            periodFrame.size.height = 3.0f * CGRectGetHeight(self.bounds) / 4.0f;
        } else  {
            periodFrame.size.height = CGRectGetHeight(self.bounds);
        }

        
        UIView *currenView = [self.subviews objectAtIndex:i];
        currenView.frame = periodFrame;
        periodFrame.origin.x = CGRectGetMaxX(periodFrame) + 1;
    }
}


-(void)reloadSubviews{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if ([self.place.rainPeriods count]<2) {
        return;
    }
    
    for (int i=0 ; i<[self.place.rainPeriods count]-1 ; i++) {
        RIDRainPeriod *period = [self.place.rainPeriods objectAtIndex:i];

        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:view];

        if (period.type == 0) {
            view.backgroundColor = [UIColor clearColor];
        } else if (period.type == 1) {
            view.backgroundColor = [UIColor colorWithRed:216.0f/255.0f green:225.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
        } else if (period.type == 2) {
            view.backgroundColor = [UIColor colorWithRed:182.0f/255.0f green:198.0f/255.0f blue:227 alpha:1.0f];
        } else if (period.type == 3) {
            view.backgroundColor = [UIColor colorWithRed:151.0f/255.0f green:165.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
        } else  {
            view.backgroundColor = [UIColor colorWithRed:45.0f/255.0f green:120.0f/255.0f blue:154.0f/255.0f alpha:1.0f];
        }
        
    }
    [self setNeedsLayout];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (context == (__bridge void *)(kvoContext)) {
        [self reloadSubviews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
