//
//  RIDPlaceCell.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 14/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import "RIDPlaceCell.h"
#import "RIDRainView.h"

@implementation RIDPlaceCell{
    RIDRainView *_rainView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _rainView = [[RIDRainView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_rainView];
    }
    return self;
}

-(void)setPlace:(RIDPlace *)place{
    self.textLabel.text = place.nom;
    self.detailTextLabel.text = place.codePostal;
    _rainView.place = place;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    CGRect frame = self.textLabel.frame;
    frame.origin.y = 5.0f;
    frame.size.height = CGRectGetHeight(self.bounds) / 2.0f;
    frame.size.height -= 7.0f;
    self.textLabel.frame = frame;
    
    frame = self.detailTextLabel.frame;
    frame.origin.y = 5.0f;
    frame.size.height = CGRectGetHeight(self.bounds) / 2.0f;
    frame.size.height -= 7.0f;
    self.detailTextLabel.frame = frame;

    frame = self.contentView.bounds;
    frame.size.width = CGRectGetWidth(frame) - 40.0f;
    frame.origin.x = 20.0f;
    frame.size.height /= 2.0f;
    frame.origin.y = CGRectGetHeight(self.contentView.bounds) - CGRectGetHeight(frame) - 2.0f;
    _rainView.frame = frame;
}

@end
