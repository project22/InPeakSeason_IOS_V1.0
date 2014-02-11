//
//  Market.h
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface Market : NSObject

- (NSDictionary *)getMarketsForLocation:(CLLocation *)userLocation;
- (NSDictionary *)getMarketDetails:(NSString *)marketID;

@end
