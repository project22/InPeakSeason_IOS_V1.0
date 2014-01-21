//
//  MarketsViewController.m
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "MarketsViewController.h"

@interface MarketsViewController ()



@end

@implementation MarketsViewController {
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSArray *markets;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    //get the users location
    [self getUserLocation];
    

}

-(void)getMarketsList {

    //get the markets nearby
    Market *marketObject = [[Market alloc]init];
        
    NSDictionary * nearbyMarkets = [marketObject getMarketsForLocation:currentLocation];
    markets = [nearbyMarkets objectForKey:@"results"];
    NSLog(@"from controller, the markets: %@", markets);
    
    
    [self.marketsTable reloadData];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return markets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    UILabel *marketName;
    
    marketName = (UILabel *)[cell viewWithTag:1];
    marketName.text =  [NSString stringWithFormat:@"%@", [[markets objectAtIndex:indexPath.row] valueForKey:@"marketname"]];
    
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toMarketDetail"]) {
        NSIndexPath *indexPath = [self.marketsTable indexPathForSelectedRow];
        MarketDetailViewController *destViewController = segue.destinationViewController;
        destViewController.marketID = [NSString stringWithFormat:@"%@", [[markets objectAtIndex:indexPath.row] valueForKey:@"id"]];
        destViewController.marketName = [NSString stringWithFormat:@"%@", [[markets objectAtIndex:indexPath.row] valueForKey:@"marketname"]];

    }
}

#pragma mark - Get User Location

-(void)getUserLocation {
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    currentLocation = newLocation;
    [locationManager stopUpdatingLocation];
    
    if (currentLocation != nil) {
        
        [self getMarketsList];  //would be better if this was called by listening for an event of the currentlLocation being set.
    }
    
    
}



@end
