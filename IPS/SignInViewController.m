//
//  SignInViewController.m
//  IPS
//
//  Created by Jon Paul Berti on 2/9/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    NSLog(@"login Controller");
    
//    // Create request for user's Facebook data
//    FBRequest *request = [FBRequest requestForMe];
//    
//    // Send request to Facebook
//    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//        if (!error) {
//            // result is a dictionary with the user's Facebook data
//            NSDictionary *userData = (NSDictionary *)result;
//            
//            NSString *facebookID = userData[@"id"];
//            NSString *name = userData[@"name"];
//            NSString *location = userData[@"location"][@"name"];
//            NSString *gender = userData[@"gender"];
//            NSString *birthday = userData[@"birthday"];
//            NSString *relationship = userData[@"relationship_status"];
//            
//            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
//            
//            // Now add the data to the UI elements
//            // ...
//            
//            NSLog(@"FB id: %@, name: %@, location: %@, gender: %@, birthday: %@, relationship: %@, picture URL: %@", facebookID, name, location, gender, birthday, relationship, pictureURL);
//        }
//    }];
}

- (IBAction)facebookLogin:(id)sender  {
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"user_about_me"];
//    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        //        [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            [self updateUserAccount];

        } else {
            NSLog(@"User with facebook logged in!");

            
            [self updateUserAccount];
            
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)updateUserAccount {
    
    // Create request for user's Facebook data
    FBRequest *request = [FBRequest requestForMe];
    
    // Send request to Facebook
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *birthday = userData[@"birthday"];
            NSString *email = userData[@"email"];
            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
//            NSString *location = userData[@"location"];
            NSString *gender = userData[@"gender"];
            NSString *firstName = userData[@"first_name"];
            NSString *lastName = userData[@"last_name"];
//            NSString *relationship = userData[@"relationship_status"];
//            NSString *FBlink = userData[@"link"];
            NSString *userTimezone = userData[@"timezone"];
            NSString *username = userData[@"username"];
            NSString *locale = userData[@"locale"];
            
            NSString *pictureURLString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID];
            
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            //convert this to a picture for parse and upload
       
            NSData *picData = [NSData dataWithContentsOfURL:pictureURL];
            PFFile *picFile = [PFFile fileWithData:picData];
            
            
            NSLog(@"***user info: %@", result);
            
            // add the rest of user date from FB to IPS DB
            
            // Retrieve the object by id
            NSString *userID = [[PFUser currentUser]valueForKey:@"objectId"];
            NSLog(@"user ID = %@", userID);
  
            PFQuery *query = [PFUser query];
            [query getObjectInBackgroundWithId:userID block:^(PFObject *userData, NSError *error) {
                // Do something with the returned PFObject in the gameScore variable.
                NSLog(@"The gamescore is: %@", userData);
                
                // Now let's update it with some new data. In this case, only cheatMode and score
                // will get sent to the cloud. playerName hasn't changed.
                userData[@"userImage"] = picFile;
                userData[@"imageURL"] = pictureURLString;
                userData[@"birthday"] = birthday;
                userData[@"email"] = email;
                userData[@"first_name"] = firstName;
                userData[@"first_name"] = lastName;
                userData[@"gender"] = gender;
//                userData[@"link"] = FBlink;
                userData[@"locale"] = locale;
                userData[@"name"] = name;
                userData[@"timezone"] = userTimezone;
                userData[@"username"] = username;
                userData[@"gender"] = gender;
//                //                userData[@"verified"] = verified;
//                userData[@"relationship"] = relationship;

                
                
                [userData saveInBackground];

            }];
            
            
            
            

            

            
            
            
//            NSLog(@"FB id: %@, name: %@, location: %@, gender: %@, birthday: %@, relationship: %@, picture URL: %@", facebookID, name, location, gender, birthday, relationship, pictureURL);
        }
    }];
}

- (IBAction)cancelLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
