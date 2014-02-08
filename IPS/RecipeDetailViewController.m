//
//  RecipeDetailViewController.m
//  IPS
//
//  Created by Jon Paul Berti on 2/7/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "RecipeDetailViewController.h"

@interface RecipeDetailViewController ()

@end

@implementation RecipeDetailViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = self.recipeTitle;
//    self.navigationController.navigationBar.topItem.title = @"";
    
    NSLog(@"from the detail the URL is %@", self.recipeURL);
    NSString *urlString = self.recipeURL;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] > 0 && error == nil) [self.webView loadRequest:request];
         else if (error != nil) NSLog(@"Error: %@", error);
     }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"Web page loaded");
    self.activityIndicator.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
