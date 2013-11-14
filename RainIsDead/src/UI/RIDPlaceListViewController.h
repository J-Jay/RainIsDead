//
//  RIDPlaceListViewController.h
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RIDRainView.h"

@protocol RIDPlaceListViewControllerDelegate;

@interface RIDPlaceListViewController : UIViewController

@property (nonatomic, weak) id<RIDPlaceListViewControllerDelegate> delegate;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@end

@protocol RIDPlaceListViewControllerDelegate <NSObject>

-(void)placeListViewController:(RIDPlaceListViewController *)controller didSelectPlace:(RIDPlace *)place;
-(void)placeListViewControllerDidCancel:(RIDPlaceListViewController *)controller;

@end