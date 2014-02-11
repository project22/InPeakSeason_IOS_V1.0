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
    
    [self.mainScrollView setContentSize:CGSizeMake(320, 1000)];
    [self.mainScrollView setScrollEnabled:YES];
    
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
            
            //Set a few MKMapView Properties to allow pitch, building view, points of interest, and zooming.
            self.mapView.pitchEnabled = YES;
//            self.mapView.showsBuildings = YES;
            [self.mapView setShowsBuildings:YES];
            self.mapView.showsPointsOfInterest = YES;
            self.mapView.zoomEnabled = YES;
            self.mapView.scrollEnabled = YES;
           
            
            
            //set up initial location
            CLLocationCoordinate2D ground = CLLocationCoordinate2DMake(point.coordinate.latitude, point.coordinate.longitude);
            CLLocationCoordinate2D eye = CLLocationCoordinate2DMake(point.coordinate.latitude - .01000, point.coordinate.longitude);
            MKMapCamera *mapCamera = [MKMapCamera cameraLookingAtCenterCoordinate:ground
                                                                fromEyeCoordinate:eye
                                                                      eyeAltitude:50];
            
            self.mapView.camera = mapCamera;
            
        }
    }];
    
    self.navigationItem.title = self.marketName;

    self.marketNameLabel.text = self.marketName;
    self.marketNameLabel.numberOfLines = 0;
    [self.marketNameLabel sizeToFit];
    
    self.outputAddressLabel.text = [marketDetails valueForKeyPath:@"marketdetails.Address"];
    self.outputAddressLabel.numberOfLines = 0;
    [self.outputAddressLabel sizeToFit];

    self.outputScheduleLabel.text = [marketDetails  valueForKeyPath:@"marketdetails.Schedule"];
    self.outputScheduleLabel.numberOfLines = 0;
    [self.outputScheduleLabel sizeToFit];
    
    self.outputProductsLabel.text = [marketDetails  valueForKeyPath:@"marketdetails.Products"];
    self.outputProductsLabel.numberOfLines = 0;
    [self.outputProductsLabel sizeToFit];
    
    
    NSString *unescaped = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/streetview?size=400x400&location=%@&fov=90&heading=235&pitch=10&sensor=false" , [marketDetails valueForKeyPath:@"marketdetails.Address"]];
    
    NSString *charactersToEscape = @" ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedString = [unescaped stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
    NSString *URLString = encodedString;    
    NSURL *imageURL = [NSURL URLWithString: URLString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    self.marketStreetView.image = image;
    
    
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
