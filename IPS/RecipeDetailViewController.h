//
//  RecipeDetailViewController.h
//  IPS
//
//  Created by Jon Paul Berti on 2/7/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeDetailViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) NSString *recipeURL;
@property (strong, nonatomic) NSString *recipeTitle;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
