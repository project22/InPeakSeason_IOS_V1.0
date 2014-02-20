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
#import "SignInViewController.h"


@interface ProductDetailViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *productNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *productImage;

@property (weak, nonatomic) PFObject *exam;

@property (strong, nonatomic) IBOutlet UIButton *addToShoppingList;

- (IBAction)addToShoppingList:(id)sender;

@end
