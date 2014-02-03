//
//  ProductDetailViewController.m
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.productNameLabel.text = [self.exam objectForKey:@"name"];
    self.navigationItem.title = [self.exam objectForKey:@"name"];
    self.triedProductQuestion.text = [NSString stringWithFormat:@"Tried local %@ lately?", [self.exam objectForKey: @"name"]];
    
  

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ratingSliderChange:(id)sender {
      NSLog(@"Slider: %f", self.ratingSlider.value);
}
@end
