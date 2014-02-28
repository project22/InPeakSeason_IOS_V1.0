//
//  MarketsMapViewController.h
//  In Peak Season
//
//  Created by Jon Paul Berti on 2/27/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import "MarketDetailViewController.h"

@interface MarketsMapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
    CLLocationManager *locationManager;
    CLLocation *userLocation;
}
- (IBAction)openListView:(id)sender;


- (void)populateMap;
- (void) showDetails:(PFObject*)marketObject;




@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
