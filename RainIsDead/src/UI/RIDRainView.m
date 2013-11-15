//
//  RIDRainView.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import "RIDRainView.h"
#import "RIDRainPeriod.h"
#import "UIColor+Adds.h"

@interface RIDRainPeriod(RIDRainView)
-(CGRect)rectForPeriodeInRect:(CGRect)rect;
@end


@interface RIDRainView()
@end

@implementation RIDRainView{
    UILabel *_startLabel;
    UILabel *_midLabel;
    UILabel *_endLabel;
    NSArray *_periodViews;
}

static NSString *kvoContext = @"RIDRainViewKvoContext";

- (void)dealloc
{
    [self removeRainPeriodsObserver];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGFloat labelHeight = CGRectGetHeight(_startLabel.bounds);

    [[UIColor blackColor] set];

	CGContextRef lc_context = UIGraphicsGetCurrentContext();
    
	CGContextSaveGState(lc_context);
    
    CGContextMoveToPoint(lc_context, 0, 0);
    CGContextAddLineToPoint(lc_context, 0, CGRectGetHeight(self.bounds)-labelHeight);
	CGContextClosePath(lc_context);
	CGContextDrawPath(lc_context, kCGPathFillStroke);

    CGContextMoveToPoint(lc_context, 0, 0);
    CGContextAddLineToPoint(lc_context, 0, CGRectGetHeight(self.bounds)-labelHeight);
	CGContextClosePath(lc_context);
	CGContextDrawPath(lc_context, kCGPathFillStroke);

    CGContextMoveToPoint(lc_context, 0, 0);
    CGContextAddLineToPoint(lc_context, 0, CGRectGetHeight(self.bounds)-labelHeight);
	CGContextClosePath(lc_context);
	CGContextDrawPath(lc_context, kCGPathFillStroke);

    CGContextMoveToPoint(lc_context, 0, 0);
    CGContextAddLineToPoint(lc_context, 0, CGRectGetHeight(self.bounds)-labelHeight);
	CGContextClosePath(lc_context);
	CGContextDrawPath(lc_context, kCGPathFillStroke);

    CGContextRestoreGState(lc_context);
}

-(void)removeRainPeriodsObserver{
    @try {
        [self removeObserver:self forKeyPath:@"place.rainPeriods"];
    }
    @catch (NSException *exception) { }
}

-(void)addRainPeriodsObserver{
    [self addObserver:self forKeyPath:@"place.rainPeriods" options:NSKeyValueObservingOptionInitial context:(__bridge void *)(kvoContext)];
}

-(UILabel *)createDateLabel{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.shadowColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:9];
    [self addSubview:label];
    return label;
}

-(void)addLabels{
    _startLabel = [self createDateLabel];
    _midLabel = [self createDateLabel];
    _endLabel = [self createDateLabel];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self addRainPeriodsObserver];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addRainPeriodsObserver];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(BOOL)isPeriodeViewCorrectlyInitializedWihtRainPeriods{
    return ([_periodViews count] == ([self.place.rainPeriods count]-1) );
}

#define kMinimumRainPeriodesCount 3
-(BOOL)hasEnoughRainPeriodes{
    return ([_periodViews count] >= kMinimumRainPeriodesCount);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (![self isPeriodeViewCorrectlyInitializedWihtRainPeriods]) {
        [self reloadSubviews];
        [self updateDatesLabels];
    }

    [self layoutDatesLabels];

    if (![self hasEnoughRainPeriodes]) {
        [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        return;
    }
    
    if (self.place.rainPeriods == nil) {
        return;
    }
    
    CGFloat labelHeight = CGRectGetHeight(_startLabel.bounds);
    
    NSTimeInterval startTime = [[[self.place.rainPeriods firstObject] startDate] timeIntervalSince1970];
    NSTimeInterval endTime = [[[self.place.rainPeriods lastObject] startDate] timeIntervalSince1970];
    NSTimeInterval periodDuration = endTime - startTime;
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    CGRect periodFrame = self.bounds;
    
    for (int i=0 ; i<[_periodViews count] ; i++) {
        NSTimeInterval curentPeriodStartTime = [[[self.place.rainPeriods objectAtIndex:i] startDate] timeIntervalSince1970];
        NSTimeInterval curentPeriodEndTime = [[[self.place.rainPeriods objectAtIndex:i+1] startDate] timeIntervalSince1970];
        NSTimeInterval curentPeriodDuration = curentPeriodEndTime - curentPeriodStartTime;
        periodFrame.size.width = (viewWidth * curentPeriodDuration / periodDuration) - 1;
        periodFrame.size.height = CGRectGetHeight(self.bounds) - labelHeight;
        RIDRainPeriod *period = [self.place.rainPeriods objectAtIndex:i];
        periodFrame = [period rectForPeriodeInRect:periodFrame];
        UIView *currenView = [_periodViews objectAtIndex:i];
        currenView.frame = periodFrame;
        periodFrame.origin.x = CGRectGetMaxX(periodFrame) + 1;
    }
    
}

-(void)layoutDatesLabels{
    [_startLabel sizeToFit];
    [_midLabel sizeToFit];
    [_endLabel sizeToFit];
    CGRect frame = _startLabel.frame;
    frame.origin.y = CGRectGetHeight(self.bounds) - CGRectGetHeight(frame);
    _startLabel.frame = frame;
    frame = _endLabel.frame;
    frame.origin.x = CGRectGetWidth(self.bounds) - CGRectGetWidth(frame);
    frame.origin.y = CGRectGetHeight(self.bounds) - CGRectGetHeight(frame);
    _endLabel.frame = frame;
    frame = _midLabel.frame;
    frame.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(frame)) / 2.0f;
    frame.origin.y = CGRectGetHeight(self.bounds) - CGRectGetHeight(frame);
    _midLabel.frame = frame;
}


-(void)updateDatesLabels{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSDate *firstDate = [[self.place.rainPeriods firstObject] startDate];
    _startLabel.text = [formatter stringFromDate:firstDate];
    NSDate *endDate = [[self.place.rainPeriods lastObject] startDate];
    _endLabel.text = [formatter stringFromDate:endDate];
    NSUInteger periodeCount = [self.place.rainPeriods count];
    if (periodeCount > 2) {
        NSUInteger midIndex = [self.place.rainPeriods count] / 2;
        NSDate *midDate = [[self.place.rainPeriods objectAtIndex:midIndex+1] startDate];
        _midLabel.text = [formatter stringFromDate:midDate];
    }
}

-(void)reloadSubviews{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if ([self.place.rainPeriods count]<2) {
        return;
    }
    
    NSMutableArray *mutPeriodViews = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i=0 ; i<[self.place.rainPeriods count]-1 ; i++) {
        RIDRainPeriod *period = [self.place.rainPeriods objectAtIndex:i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:view];
        [mutPeriodViews addObject:view];
        view.backgroundColor = [UIColor colorForPeriod:period];
    }
    _periodViews = [NSArray arrayWithArray:mutPeriodViews];
    [self addLabels];
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (context == (__bridge void *)(kvoContext)) {
        [self reloadSubviews];
        [self updateDatesLabels];
        [self setNeedsLayout];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end


@implementation RIDRainPeriod(RIDRainView)

-(CGRect)rectForPeriodeInRect:(CGRect)rect{
    CGRect outFrame = rect;
    switch (self.type) {
        case RIDRainPeriodTypeNoData:
            outFrame.size.height = 0.0f;
            break;

        case RIDRainPeriodTypeNoRain:
            outFrame.size.height =  1.0f;
            break;

        case RIDRainPeriodTypeSmallRain:
            outFrame.size.height = 1.0f * (CGRectGetHeight(rect)) / 3.0f;
            break;

        case RIDRainPeriodTypeRain:
            outFrame.size.height = 2.0f * (CGRectGetHeight(rect)) / 3.0f;
            break;

        case RIDRainPeriodTypeBigRain:
            outFrame.size.height = 3.0f * (CGRectGetHeight(rect)) / 3.0f;
            break;

        default:
            outFrame.size.height = 0.0f;
            break;
    }

    outFrame.origin.y = CGRectGetHeight(rect) - CGRectGetHeight(outFrame);
    return outFrame;
}

@end