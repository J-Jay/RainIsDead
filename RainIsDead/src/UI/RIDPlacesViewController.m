//
//  RIDPlacesViewController.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 14/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import "RIDPlacesViewController.h"
#import "RIDPlaceListViewController.h"
#import "RIDFavoritePlacesHelper.h"
#import "RIDPlaceCell.h"

@interface RIDPlacesViewController () <RIDPlaceListViewControllerDelegate>

@end

@implementation RIDPlacesViewController{
    RIDFavoritePlacesHelper *_favoritePlacesHelper;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Rain Is Dead !";
    self.tableView.rowHeight = 60.0f;
    _favoritePlacesHelper = [[RIDFavoritePlacesHelper alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPlace:)];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIRefreshControl *lcRefreshControl = [[UIRefreshControl alloc]init];
	[lcRefreshControl addTarget:self action:@selector(refreshAll:) forControlEvents:UIControlEventValueChanged];
	self.refreshControl=lcRefreshControl;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(placeRainHelperDidUpdateStatus:) name:@"RIDPlaceRainHelperDidUpdateStatus" object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
	self.refreshControl.tintColor = self.view.tintColor;
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RIDPlaceRainHelperDidUpdateStatus" object:nil];
}

-(void)placeRainHelperDidUpdateStatus:(NSNotification *)notification{
    NSInteger requsetCount = [[[notification userInfo] objectForKey:@"RIDPlaceRainHelperRequestCount"] integerValue];
    if (requsetCount == 0) {
        [self.refreshControl endRefreshing];
    }
}

-(void)addPlace:(id)sender{
    RIDPlaceListViewController *ctrl = [[RIDPlaceListViewController alloc] initWithNibName:@"RIDPlaceListViewController" bundle:nil];
    ctrl.delegate = self;
    [self.navigationController presentViewController:ctrl animated:YES completion:nil];
}

-(void)refreshAll:(UIRefreshControl *)lcRefreshControl{
    [_favoritePlacesHelper updateAllPlaces];
}

#pragma mark - RIDPlaceListViewControllerDelegate

-(void)placeListViewController:(RIDPlaceListViewController *)controller didSelectPlace:(RIDPlace *)place{
    [_favoritePlacesHelper addPlace:place];
    [self.tableView reloadData];
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)placeListViewControllerDidCancel:(RIDPlaceListViewController *)controller{
    [controller dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_favoritePlacesHelper placesCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RIDPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[RIDPlaceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    RIDPlace *place = [_favoritePlacesHelper placeAtIndex:indexPath.row];
    [cell setPlace:place];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_favoritePlacesHelper removePlaceAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [_favoritePlacesHelper movePlaceAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

@end
