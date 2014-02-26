//
//  AddCommentViewController.m
//  IPS
//
//  Created by Jon Paul Berti on 2/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "AddCommentViewController.h"

@interface AddCommentViewController ()

@end

@implementation AddCommentViewController {
    NSString *city;
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
    
    self.postButton.enabled = NO;
    geocoder = [[CLGeocoder alloc] init];
//    self.comment.clearsOnInsertion = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearTextField)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:self.comment];
    
}

-(void)clearTextField {
    self.comment.text = @"";
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    userLocation = newLocation;


    //    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    [locationManager stopUpdatingLocation];
    

    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:userLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            city = [NSString stringWithFormat:@"%@",
                                  placemark.locality
                                 ];
            NSLog(@"City: %@", city);
            self.postButton.enabled = YES;
        } else {
            NSLog(@"%@", error.debugDescription);
            [self dismissViewControllerAnimated:YES completion:nil];
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Problem"
                                                              message:@"Your location cannot determined.  This is needed to post comments locally."
                                                             delegate:nil
                                                    cancelButtonTitle:@"Darn, but OK"
                                                    otherButtonTitles:nil];
            
            [message show];
        }
    } ];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"Editing");
    self.comment.text = @"";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)postComment:(id)sender {
    
    if ([PFUser currentUser] != nil) {
        
        NSLog(@"logged in");
        PFUser *user = [PFUser currentUser];
        
        // Make a new post
        PFObject *comment = [PFObject objectWithClassName:@"Buzz"];
        
        comment[@"userId"] = user;
        comment[@"comment"] = self.comment.text;
        comment[@"status"] = @"approved";
        
        CLLocationCoordinate2D coordinate = [userLocation coordinate];
        PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude
                                                      longitude:coordinate.longitude];
        
        comment[@"GeoPoint"] = geoPoint;
        
        comment[@"city"] = city;
        
        [comment save];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Thank You"
                                                          message:@"Your post was submitted and will be reviewed shortly."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        
        
    } else {
        NSLog(@"Not logged in");
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"loginScreen"];
        
        
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        
        
        [self presentViewController:vc animated:YES completion:nil];
        
        
    }
}
- (IBAction)cancelComment:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
