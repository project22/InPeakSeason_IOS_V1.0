//
//  ProductDetailViewController.h
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProductDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *productNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *triedProductQuestion;
@property (weak, nonatomic) PFObject *exam;
@property (strong, nonatomic) IBOutlet UISlider *ratingSlider;
- (IBAction)ratingSliderChange:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;

@end
