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



@interface MarketDetailViewController : UIViewController <MKMapViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UIButton *addressButton;
- (IBAction)addressButtonTouch:(id)sender;


@property (strong, nonatomic) NSString *marketName;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) PFObject *exam;



@end
