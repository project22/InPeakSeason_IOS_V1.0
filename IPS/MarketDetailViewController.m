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
    
    self.marketNameLabel.text = self.marketName;
//    self.outputAddressLabel.text = [NSString stringWithFormat:@"%@", [marketDetails objectAtIndex:indexPath.row] valueForKey:@"marketname"]];
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    NSLog(@"I should show my location now");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
