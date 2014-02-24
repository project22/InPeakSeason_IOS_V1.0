//
//  SignInViewController.h
//  IPS
//
//  Created by Jon Paul Berti on 2/9/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SignInViewController : UIViewController

- (IBAction)facebookLogin:(id)sender;

- (IBAction)cancelLogin:(id)sender;

- (void)updateUserAccount;

@end
