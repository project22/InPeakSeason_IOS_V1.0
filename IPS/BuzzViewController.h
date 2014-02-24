//
//  BuzzViewController.h
//  IPS
//
//  Created by Jon Paul Berti on 2/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>

@interface BuzzViewController : PFQueryTableViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *userLocation;
}

- (IBAction)addComment:(id)sender;
@end
