//
//  Product.m
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "Product.h"

@implementation Product

- (NSMutableArray *)getLocalProductsInSeason:(CLLocation *)userLocation {
    
    NSMutableArray *productsArray = [[NSMutableArray alloc] init];
    
    NSLog(@"Model for products running");
    
//    There is a problem with variable types.  Need to spike on NSArray and Parse
//    USing dictionary vs array.  Dictionaries.  What are there exactly?
//    Does parse work with dictionaries?
//    
    PFQuery *query = [PFQuery queryWithClassName:@"Season"];
    [query whereKey:@"region" equalTo:@"California"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            [productsArray addObjectsFromArray:objects];
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu seasons.", (unsigned long)objects.count);
        
            // Do something with the found objects
            for (PFObject *object in productsArray) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    return productsArray;
    
}

@end
