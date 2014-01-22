//
//  Product.h
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Product : NSObject

// return a dictionary with all the products and related data.
// List
- (NSMutableArray *)getLocalProductsInSeason:(CLLocation *)userLocation;


@end
