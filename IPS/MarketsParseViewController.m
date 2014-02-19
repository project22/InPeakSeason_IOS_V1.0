//
//  MarketsParseViewController.m
//  IPS
//
//  Created by Jon Paul Berti on 2/10/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "MarketsParseViewController.h"

@interface MarketsParseViewController ()

@property (strong, nonatomic)NSString *className;

@end

@implementation MarketsParseViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    //    UINavigationBar *navBar = self.navigationController.navigationBar;
    //    UIImage *image = [UIImage imageNamed:@"peak-thumbnail.png"];
    //    [navBar setBackgroundImage:image forBarMetrics:(UIBarMetricsDefault)];
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    userLocation = newLocation;
    [self queryForTable];
    [self loadObjects];
    
    
//    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
//    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    [locationManager stopUpdatingLocation];
}


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        
//        self.className = @"Product";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
    }
    return self;
}

- (PFQuery *)queryForTable {
    
    // get actual user location!!
    
    PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:userLocation.coordinate.latitude
                                                      longitude:userLocation.coordinate.longitude];
    PFQuery *query = [PFQuery queryWithClassName:@"Market"];
    [query whereKey:@"GeoPoint" nearGeoPoint:userGeoPoint withinMiles:5.0];

//    
//    NSArray *placeObjects = [query findObjects];
//    NSLog(@"%@", placeObjects);
    
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
//    [query orderByDescending:@"GeoPoint"];
    [query whereKey:@"GeoPoint" nearGeoPoint:userGeoPoint];
    
    
//    [query orderByDescending:@"createdAt"];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    UILabel *marketName;
    marketName = (UILabel *)[cell viewWithTag:1];
    //    productName.numberOfLines = 0;
    //    [productName sizeToFit];
    marketName.text = [object objectForKey:@"MarketName"];
    

    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Check that a new transition has been requested to the DetailViewController and prepares for it
    if ([segue.identifier isEqualToString:@"toMarketDetail"]){
        
        NSLog(@"clicked");
        
        // Capture the object (e.g. exam) the user has selected from the list
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        
        // Set destination view controller to DetailViewController to avoid the NavigationViewController in the middle (if you have it embedded into a navigation controller, if not ignore that part)
        
        MarketDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.exam = object;
    }
}


@end
