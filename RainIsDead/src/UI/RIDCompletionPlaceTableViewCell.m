//
//  RIDCompletionPlaceTableViewCell.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 17/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import "RIDCompletionPlaceTableViewCell.h"

@implementation RIDCompletionPlaceTableViewCell

-(void)configureForPlace:(RIDPlace *)place{
    self.textLabel.text = place.nom;
    self.detailTextLabel.text = place.codePostal;
    
    if (place.couvertPluie) {
        self.textLabel.textColor = [UIColor blackColor];
        self.detailTextLabel.textColor = [UIColor blackColor];
    } else {
        self.textLabel.textColor = [UIColor lightGrayColor];
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
}

@end
