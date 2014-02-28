//
//  MarketsMapViewController.m
//  In Peak Season
//
//  Created by Jon Paul Berti on 2/27/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "MarketsMapViewController.h"

@interface MarketsMapViewController ()

@end

@implementation MarketsMapViewController



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
    [self populateMap];

    
    //    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    //    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    [locationManager stopUpdatingLocation];
}


- (IBAction)openListView:(id)sender {
    NSLog(@"Opening List View");
    [self performSegueWithIdentifier:@"toListView" sender:self];
}

- (void)populateMap {
    
    PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:userLocation.coordinate.latitude
                                                      longitude:userLocation.coordinate.longitude];
    PFQuery *query = [PFQuery queryWithClassName:@"Market"];
    [query whereKey:@"GeoPoint" nearGeoPoint:userGeoPoint withinMiles:5.0];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d markets.", objects.count);
            
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 10000, 10000);
            [self.mapView setRegion:[self.mapView regionThatFits:region] animated:NO];
        
            // Do something with the found objects
            for (PFObject *object in objects) {
                PFGeoPoint *geoPoint = [object objectForKey:@"GeoPoint"];
                NSLog(@"%@", geoPoint);
                NSLog(@"somethign: %f", geoPoint.latitude);
                
                // Add an annotation
                CLLocationCoordinate2D marketCoordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
                MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//                MKAnnotationView *annotation = [[MKAnnotationView alloc]init];
                
                
                point.coordinate = marketCoordinate;
               
                
                point.title = [object objectForKey:@"MarketName"];
//                UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//                [rightButton addTarget:self action:@selector(showDetails) forControlEvents:UIControlEventTouchUpInside];
//                annotation.rightCalloutAccessoryView = rightButton;
//                point.subtitle = @"I'm here!!!";
                
                [self.mapView addAnnotation:point];
                
//                GeoPointAnnotation *geoPointAnnotation = [[GeoPointAnnotation alloc]
//                                                          initWithObject:object];
//                [self.mapView addAnnotation:geoPointAnnotation];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    

    
}





- (void) showDetails:(PFObject*)marketObject {
    NSLog(@"opening market detail");
    MarketDetailViewController *marketDetail = [[MarketDetailViewController alloc] init ];
    
}


    





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
