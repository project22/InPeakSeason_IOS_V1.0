//
//  Market.m
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//


#import "Market.h"

@implementation Market

- (NSDictionary *)getMarketsForLocation:(CLLocation *)userLocation {
    
    NSMutableDictionary *marketDictionary;
    
    if (userLocation != nil) {

        CLLocationCoordinate2D coordinate = [userLocation coordinate];
        PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude
                                                      longitude:coordinate.longitude];
    
        PFQuery *marketQuery = [PFQuery queryWithClassName:@"Market"];
        [marketQuery whereKey:@"GeoPoint" nearGeoPoint:geoPoint withinMiles:5.0];
        
        [marketQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                [marketDictionary setObject:objects forKey:@"results"];
                NSLog(@"results: %@", [marketDictionary objectForKey:@"results"]);
                
                for (PFObject *object in objects) {
//                    NSLog(@"Market name: %@", [object objectForKey:@"MarketName"]);
                    
//                    GeoPointAnnotation *geoPointAnnotation = [[GeoPointAnnotation alloc]
//                                                              initWithObject:object];
//                    [self.mapView addAnnotation:geoPointAnnotation];
                }
            }
        }];
        
        
        // Run query on Parse DB for markets
//        PFQuery *marketQuery = [PFQuery queryWithClassName:@"Market"];
//        [seasonQuery whereKey:@"month" equalTo:@"2"];
//        
//        
//        [seasonQuery whereKey:@"quality" greaterThan:[NSNumber numberWithInt:3]];
        
        //run the JSON query to USDA api
//        NSString *jsonString = [[NSString alloc]initWithFormat: @"http://search.ams.usda.gov/farmersmarkets/v1/data.svc/locSearch?lat=%@&lng=%@", lat, lng ];
//        NSURL *jsonURL = [NSURL URLWithString:jsonString];
//    
//        NSData *jsonData = [NSData dataWithContentsOfURL:jsonURL];
//        NSError *fetchMarketsError;
//        marketDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&fetchMarketsError];
        
//        NSLog(@"NS dictionary %@", marketDictionary);
        //populate Parse DB with new records found
        
    }
    
    return marketDictionary;
}

- (NSDictionary *)getMarketDetails:(NSString *)marketID {
    
    NSDictionary *marketDetails;
    
    
    //run the JSON query to USDA api
    NSString *jsonString = [[NSString alloc]initWithFormat: @"http://search.ams.usda.gov/farmersmarkets/v1/data.svc/mktDetail?id=%@", marketID ];
    NSURL *jsonURL = [NSURL URLWithString:jsonString];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonURL];
    NSError *fetchMarketsError;
    marketDetails = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&fetchMarketsError];
    
    
    return marketDetails;
}

@end
