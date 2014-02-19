//
//  MarketDetailViewController.m
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "MarketDetailViewController.h"

@interface MarketDetailViewController ()

@end

@implementation MarketDetailViewController
@synthesize mapView;


//- (void)setGeoPoint:(PFGeoPoint *)geoPoint {
//    _coordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
//    
//    static NSDateFormatter *dateFormatter = nil;
//    if (dateFormatter == nil) {
//        dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
//        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
//    }
//    
//    static NSNumberFormatter *numberFormatter = nil;
//    if (numberFormatter == nil) {
//        numberFormatter = [[NSNumberFormatter alloc] init];
//        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
//        [numberFormatter setMaximumFractionDigits:3];
//    }
//    
//    _title = [dateFormatter stringFromDate:[self.object updatedAt]];
//    _subtitle = [NSString stringWithFormat:@"%@, %@", [numberFormatter stringFromNumber:[NSNumber numberWithDouble:geoPoint.latitude]],
//                 [numberFormatter stringFromNumber:[NSNumber numberWithDouble:geoPoint.longitude]]];
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@", self.exam);
    
    
	// Do any additional setup after loading the view.
    self.mapView.delegate = self;
    
    [self.mainScrollView setContentSize:CGSizeMake(320, 1000)];
    [self.mainScrollView setScrollEnabled:YES];
    
    
    self.navigationItem.title = [self.exam objectForKey:@"MarketName"];

    self.marketNameLabel.text = [self.exam objectForKey:@"MarketName"];
    self.marketNameLabel.numberOfLines = 0;
    [self.marketNameLabel sizeToFit];
    
    self.outputAddressLabel.text = [self.exam objectForKey:@"street"];
    self.outputAddressLabel.numberOfLines = 0;
    [self.outputAddressLabel sizeToFit];

//    self.outputScheduleLabel.text = [self.exam objectForKey:@"Season1Date"];
//    self.outputScheduleLabel.numberOfLines = 0;
//    [self.outputScheduleLabel sizeToFit];
    
//    self.outputProductsLabel.text = [marketDetails  valueForKeyPath:@"marketdetails.Products"];
//    self.outputProductsLabel.numberOfLines = 0;
//    [self.outputProductsLabel sizeToFit];
    
    
//    NSString *unescaped = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/streetview?size=400x400&location=%@&fov=90&heading=235&pitch=10&sensor=false" , [self.exam objectForKey:@"GeoPoint"]];
//    
//    NSString *charactersToEscape = @" ";
//    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
//    NSString *encodedString = [unescaped stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
//    
//    NSString *URLString = encodedString;    
//    NSURL *imageURL = [NSURL URLWithString: URLString];
//    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
//    UIImage *image = [UIImage imageWithData:imageData];
//    self.marketStreetView.image = image;
    
    
//    http://maps.googleapis.com/maps/api/streetview?size=400x400&location=40.720032,-73.988354&fov=90&heading=235&pitch=10&sensor=false

    
}

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{
////    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
////    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
//    
//    Market *market = [[Market alloc] init];
//    NSDictionary *marketDetails = [market getMarketDetails:self.marketID];
//    
//    
//    
//}

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
//    NSLog(@"I should show my location now");
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
