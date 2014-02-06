//
//  Recipe.m
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

- (NSDictionary *)getRecipes:(NSString *)productName {
    
    //check to see network connection
    
    NSLog(@"product: %@", productName);
    NSDictionary *relatedRecipes;
    
    //dbeba36bca60ed831f5afa391a4a1cc8
    NSString *charactersToEscape = @" ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *productNameReformatted = [productName stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
    //run the JSON query to USDA api
    NSString *jsonString = [[NSString alloc]initWithFormat: @"http://food2fork.com/api/search?key=dbeba36bca60ed831f5afa391a4a1cc8&q=%@", productNameReformatted ];
    NSURL *jsonURL = [NSURL URLWithString:jsonString];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonURL];
    NSError *fetchError;
    relatedRecipes = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&fetchError];
    
//    NSLog(relatedRecipes);
    
    return relatedRecipes;
}

@end
