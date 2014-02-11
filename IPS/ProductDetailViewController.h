//
//  ProductDetailViewController.h
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Recipe.h"


@interface ProductDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *productNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *productImage;

@property (weak, nonatomic) PFObject *exam;


@end
