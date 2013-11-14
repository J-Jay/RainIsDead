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

//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Rain Is Dead !";
    self.tableView.rowHeight = 60.0f;
    _favoritePlacesHelper = [[RIDFavoritePlacesHelper alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPlace:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addPlace:(id)sender{
    RIDPlaceListViewController *ctrl = [[RIDPlaceListViewController alloc] initWithNibName:@"RIDPlaceListViewController" bundle:nil];
    ctrl.delegate = self;
    [self.navigationController presentViewController:ctrl animated:YES completion:nil];
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

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_favoritePlacesHelper removePlaceAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
