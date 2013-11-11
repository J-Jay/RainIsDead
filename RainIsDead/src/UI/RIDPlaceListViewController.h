//
//  RIDPlaceListViewController.h
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RIDRainView.h"

@interface RIDPlaceListViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UILabel *placeName;
@property (nonatomic, strong) IBOutlet RIDRainView *rainView;

@end
