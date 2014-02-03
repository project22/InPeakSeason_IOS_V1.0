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



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.mapView.delegate = self;
    
    Market *market = [[Market alloc] init];
    NSDictionary *marketDetails = [market getMarketDetails:self.marketID];
    NSLog(@"Market details are: %@", marketDetails);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:[marketDetails  valueForKeyPath:@"marketdetails.Address"] completionHandler:^(NSArray* placemarks, NSError* error){
        for (CLPlacemark* aPlacemark in placemarks)
        {
            // Process the placemark.
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = aPlacemark.location.coordinate;
            point.title = self.marketName;
//            point.subtitle = @"Cool";
            
            [self.mapView addAnnotation:point];
            
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(aPlacemark.location.coordinate, 1000, 1000);
            [self.mapView setRegion:[self.mapView regionThatFits:region] animated:NO];
            
        }
    }];
    
    self.navigationItem.title = self.marketName;

    self.marketNameLabel.text = self.marketName;
    self.marketNameLabel.numberOfLines = 0;
    [self.marketNameLabel sizeToFit];
    
    self.outputAddressLabel.text = [marketDetails  valueForKeyPath:@"marketdetails.Address"];
    self.outputAddressLabel.numberOfLines = 0;
    [self.outputAddressLabel sizeToFit];

    self.outputScheduleLabel.text = [marketDetails  valueForKeyPath:@"marketdetails.Schedule"];
    self.outputScheduleLabel.numberOfLines = 0;
    [self.outputScheduleLabel sizeToFit];
    
    
    
    self.outputProductsLabel.numberOfLines = 0;
    [self.outputProductsLabel sizeToFit];
    self.outputProductsLabel.text = [marketDetails  valueForKeyPath:@"marketdetails.Products"];
    

    
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
