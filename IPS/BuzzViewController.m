//
//  BuzzViewController.m
//  IPS
//
//  Created by Jon Paul Berti on 2/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "BuzzViewController.h"

@interface BuzzViewController ()

@property (strong, nonatomic)NSString *className;

@end

@implementation BuzzViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        
        self.className = @"Buzz";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    userLocation = newLocation;
    [self queryForTable];
    [self loadObjects];
    
    
    //    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
     NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    [locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PFQuery *)queryForTable {
    
    PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:userLocation.coordinate.latitude
                                                      longitude:userLocation.coordinate.longitude];
    PFQuery *listQuery = [PFQuery queryWithClassName:@"Buzz"];
    [listQuery whereKey:@"GeoPoint" nearGeoPoint:userGeoPoint withinMiles:60.0];
    
    NSDate *now = [NSDate date];
    NSDate *pastDate = [now dateByAddingTimeInterval:-60*24*60*60];
    [listQuery whereKey:@"updatedAt" greaterThan:pastDate];
    
    [listQuery whereKey:@"status" equalTo:@"approved"];
    
    
    return listQuery;
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
    
    
    UILabel *userName;
    userName = (UILabel *)[cell viewWithTag:2];
    //    productName.numberOfLines = 0;
    //    [productName sizeToFit];
    userName.text = @"JP BERTI";
    
//    [object objectForKey:@"name"];
    
//    UIImageView *userImage;
//    userImage = (UIImageView *)[cell viewWithTag:1];
//    
//    PFFile *imageFile = [object objectForKey:@"image"];
//    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
//        if (!error) {
//            UIImage *MyPicture = [UIImage imageWithData:data];
//            userImage.image = MyPicture;
//        }
//    }];
//    [userImage setClipsToBounds:YES];
    
    UILabel *comment;
    comment = (UILabel *)[cell viewWithTag:3];
//    comment.numberOfLines = 0;
//    [comment sizeToFit];
    comment.text = [object objectForKey:@"comment"];
    
    UILabel *city;
    NSString *commentLocation = [[NSString alloc] initWithFormat:@"Posted in %@", [object objectForKey:@"city"]];
    city = (UILabel *)[cell viewWithTag:5];
    city.text = commentLocation;
    
    UILabel *date;
    date = (UILabel *)[cell viewWithTag:4];
    date.text = [object objectForKey:@"updatedAt"];
    
    
    return cell;
}


- (IBAction)addComment:(id)sender {
    if ([PFUser currentUser] != nil) {
        
        NSLog(@"logged in");
        // present popup;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"addComment"];
        
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:vc animated:YES completion:nil];

        
        
    } else {
        NSLog(@"Not logged in");
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"loginScreen"];
        
        
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        
        
        [self presentViewController:vc animated:YES completion:nil];
        
        
    }
    
}
@end
