//
//  Market.h
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Market : NSObject

- (NSDictionary *)GetMarketsForLocation:(CLLocation *)userLocation;

@end
