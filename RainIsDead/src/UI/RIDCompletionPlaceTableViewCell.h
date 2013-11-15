//
//  RIDCompletionPlaceTableViewCell.h
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 17/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RIDPlace.h"

@interface RIDCompletionPlaceTableViewCell : UITableViewCell
-(void)configureForPlace:(RIDPlace *)place;
@end
