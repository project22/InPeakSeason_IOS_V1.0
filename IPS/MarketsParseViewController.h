//
//  MarketsParseViewController.h
//  IPS
//
//  Created by Jon Paul Berti on 2/10/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import "MarketDetailViewController.h"


@interface MarketsParseViewController : PFQueryTableViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *userLocation;
}

@end
