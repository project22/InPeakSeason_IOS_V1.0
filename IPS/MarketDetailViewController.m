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





- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
    PFGeoPoint *marketPoint = [self.exam objectForKey:@"GeoPoint"];
    
//    CLLocation *mapCenter = [[CLLocation alloc] initWithLatitude:(userLocation.coordinate.longitude - marketPoint.longitude) longitude:(userLocation.coordinate.latitude - marketPoint.latitude) ];
//    
//    float mapWidth = fabsf(userLocation.coordinate.longitude - marketPoint.longitude) * 200000;
//    float mapHeight = fabsf(userLocation.coordinate.latitude - marketPoint.latitude) * 200000;
    
    
//    
//    NSLog(@"mapWidth = %f", mapWidth);
//    NSLog(@"mapHeight = %f", mapHeight);
//    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 16093.4, 16093.4);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    // Add an annotation
    

    
    CLLocationCoordinate2D pinCoordinate;
    pinCoordinate.latitude = marketPoint.latitude;
    pinCoordinate.longitude = marketPoint.longitude;
    
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    
    
    point.coordinate = pinCoordinate;
//    point.title = @"Where am I?";
//    point.subtitle = @"I'm here!!!";
    
    [self.mapView addAnnotation:point];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    self.mapView.delegate = self;
    

    [self.mainScrollView setContentSize:CGSizeMake(320, 1000)];
    [self.mainScrollView setScrollEnabled:YES];
    
    
    self.navigationItem.title = [self.exam objectForKey:@"MarketName"];
    
    NSString *fullAddress = [[NSString alloc] initWithFormat:@"%@, %@", [self.exam objectForKey:@"street"], [self.exam objectForKey:@"city"]];
    
    [self.addressButton setTitle:fullAddress forState:UIControlStateNormal];
    
    
    
    NSString *season1Date = [self.exam objectForKey:@"Season1Date"];
    if (season1Date) {
        NSLog(@"Season 1:%@", season1Date);
    }
    NSString *season2Date = [self.exam objectForKey:@"Season2Date"];
    if (!season2Date == NULL) {
        NSLog(@"Season 2: %@", season2Date);
    }
    NSString *season3Date = [self.exam objectForKey:@"Season3Date"];
    if (season3Date) {
        NSLog(@"Season 3: %@", season2Date);
    }


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





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)addressButtonTouch:(id)sender {
    
    PFGeoPoint *marketPoint = [self.exam objectForKey:@"GeoPoint"];
    CLLocationCoordinate2D rdOfficeLocation = CLLocationCoordinate2DMake(marketPoint.latitude, marketPoint.longitude);
    
    //Apple Maps, using the MKMapItem class
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:rdOfficeLocation addressDictionary:nil];
    MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
    item.name = [self.exam objectForKey:@"MarketName"];
    [item openInMapsWithLaunchOptions:nil];
}



@end
