//
//  AddCommentViewController.h
//  IPS
//
//  Created by Jon Paul Berti on 2/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>

@interface AddCommentViewController : UIViewController <UITextFieldDelegate, CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *userLocation;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}


@property (strong, nonatomic) IBOutlet UITextView *comment;
@property (strong, nonatomic) IBOutlet UIButton *postButton;

- (IBAction)postComment:(id)sender;

- (IBAction)cancelComment:(id)sender;

@end
