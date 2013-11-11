//
//  RIDPlaceListViewController.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import "RIDPlaceListViewController.h"
#import "RIDCompletionHelper.h"
#import "RIDPlace.h"

@interface RIDPlaceListViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *places;
@end

@implementation RIDPlaceListViewController


- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    RIDCompletionHelper *completionHelper = [[RIDCompletionHelper alloc] init];
    [completionHelper placesWithInput:searchBar.text completionHandler:^(NSArray *places, NSError *connectionError) {
        NSLog(@"places : %@", places);
        self.places = places;
        [self.tableView reloadData];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *placeCellId = @"PlaceCellId";
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:placeCellId];
    if (tableViewCell == nil) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:placeCellId];
    }
    
    RIDPlace *place = [self.places objectAtIndex:indexPath.row];
    tableViewCell.textLabel.text = place.nom;
    
    return tableViewCell;
}

@end
