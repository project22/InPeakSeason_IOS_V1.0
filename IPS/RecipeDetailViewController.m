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
    self.webView.hidden = YES;
    self.navigationItem.title = self.recipeTitle;
//    self.navigationController.navigationBar.topItem.title = @"";
    
    //favorite button
    UIBarButtonItem *favButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"+"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(addFavorite)];
    
    self.navigationItem.rightBarButtonItem = favButton;
    self.webView.delegate = self;
    
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

- (void)addFavorite {
    NSLog(@"add favorite");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"Web page loaded");
    self.activityIndicator.hidden = YES;
    self.webView.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
