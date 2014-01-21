//
//  Market.m
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//


#import "Market.h"

@implementation Market

- (NSDictionary *)GetMarketsForLocation:(CLLocation *)userLocation {
    
    NSDictionary *marketDictionary;
    
    if (userLocation != nil) {
        NSString *lat = [NSString stringWithFormat:@"%.8f", userLocation.coordinate.latitude];
        NSString *lng = [NSString stringWithFormat:@"%.8f", userLocation.coordinate.longitude];
    
        //run the JSON query to USDA api
        NSString *jsonString = [[NSString alloc]initWithFormat: @"http://search.ams.usda.gov/farmersmarkets/v1/data.svc/locSearch?lat=%@&lng=%@", lat, lng ];
        NSURL *jsonURL = [NSURL URLWithString:jsonString];
    
        NSData *jsonData = [NSData dataWithContentsOfURL:jsonURL];
        NSError *fetchMarketsError;
        marketDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&fetchMarketsError];
        
//        NSLog(@"NS dictionary %@", marketDictionary);
    }
    
    return marketDictionary;
}

@end
