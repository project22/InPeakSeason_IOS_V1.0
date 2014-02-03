//
//  Product.m
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "Product.h"

@implementation Product

- (NSDictionary *)getProductDetails:(NSString *)productName {
    
    //check to see network connection
    
    
    NSDictionary *relatedRecipes;
    
    //dbeba36bca60ed831f5afa391a4a1cc8
    
    //run the JSON query to USDA api
    NSString *jsonString = [[NSString alloc]initWithFormat: @"http://food2fork.com/api/search?key=dbeba36bca60ed831f5afa391a4a1cc8&q=%@", productName ];
    NSURL *jsonURL = [NSURL URLWithString:jsonString];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonURL];
    NSError *fetchError;
    relatedRecipes = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&fetchError];
    
    NSLog(relatedRecipes);
    
    return relatedRecipes;
}

@end
