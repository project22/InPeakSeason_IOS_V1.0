//
//  MarketDetailViewController.h
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Market.h"


@interface MarketDetailViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *marketStreetView;
@property (strong, nonatomic) NSString *marketID;
@property (strong, nonatomic) NSString *marketName;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *marketNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *outputAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *outputProductsLabel;
@property (weak, nonatomic) IBOutlet UILabel *outputScheduleLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;


@property (weak, nonatomic) PFObject *exam;



@end
