//
//  ProductDetailViewController.m
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "RecipeDetailViewController.h"

@interface ProductDetailViewController ()




@property (strong, nonatomic) IBOutlet UIScrollView *recipeScrollView;

- (void)openRecipeURL:(NSString*)URL;

@end

@implementation ProductDetailViewController {
    NSArray *recipeArray;
    long selectedRecipeIndex;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // This cleans up the spacing under the navbar.  

    NSLog(@"Object ID %@", [_exam objectId] );
    
    self.productNameLabel.text = [self.exam objectForKey:@"name"];
    self.navigationItem.title = [self.exam objectForKey:@"name"];
    
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    
    PFFile *imageFile = [self.exam objectForKey:@"image"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        if (!error) {
            UIImage *MyPicture = [UIImage imageWithData:data];
            self.productImage.image = MyPicture;
            
//            [self.navigationController.navigationBar setBackgroundImage:MyPicture forBarMetrics:UIBarMetricsDefault];
        }
    }];
    [self.productImage setClipsToBounds:YES];
    
    
    
    Recipe *recipes = [[Recipe alloc] init];
    
    NSDictionary *recipeDictionary = [recipes getRecipes: [self.exam objectForKey:@"name"]];
    
    recipeArray = [recipeDictionary objectForKey:@"recipes"];
//    NSLog(@"from controller, the recipes are: %@", recipeArray);

    //output recipes into scroll view
    self.recipeScrollView.contentSize = CGSizeMake(self.recipeScrollView.frame.size.width * recipeArray.count, self.recipeScrollView.frame.size.height);
    
    for (int i = 0; i < recipeArray.count; i++) {
        CGRect frame;
        frame.origin.x = self.recipeScrollView.frame.size.width * i;
        frame.origin.y = 0;
//        frame.size.width = 50;
//        frame.size.height =
        frame.size = self.recipeScrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        
        UIImageView *recipeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.recipeScrollView.frame.size.width, self.recipeScrollView.frame.size.height)];
        
        recipeImage.contentMode = UIViewContentModeScaleAspectFill;
        [recipeImage setClipsToBounds:YES];
        [subview addSubview:recipeImage];
        
        
        NSString * recipeImageURL = [NSString stringWithFormat:@"%@", [[recipeArray objectAtIndex:i] valueForKey:@"image_url"]];
        NSURL *imageURL = [NSURL URLWithString: recipeImageURL];
        

        NSURLRequest* request = [NSURLRequest requestWithURL:imageURL];
        
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse * response,
                                                   NSData * data,
                                                   NSError * error) {
                                   if (!error){
                                       UIImage* image = [[UIImage alloc] initWithData:data];
                                       [recipeImage setImage:image];
                                       // do whatever you want with image
                                   }
                                   
                               }];
        
        
        UILabel *recipeTitle =[[UILabel alloc] initWithFrame:CGRectMake(10,190,self.recipeScrollView.frame.size.width -20, 40)];
        recipeTitle.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        recipeTitle.textAlignment = NSTextAlignmentCenter;
        
        NSString *recipeName = [[recipeArray objectAtIndex:i] valueForKey:@"title"];
       
        
        recipeTitle.text =  [recipeName stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        
        [subview addSubview:recipeTitle];
        
        UIButton *URLbutton = [[UIButton alloc] initWithFrame:CGRectMake(200, 10, 100, 20)];
        URLbutton.backgroundColor = [UIColor orangeColor];
        [URLbutton setTitle:@"View Recipe" forState:UIControlStateNormal];
        URLbutton.tag = i;
        
        [URLbutton addTarget:self action:@selector(openRecipeURL:) forControlEvents:UIControlEventTouchUpInside];
        [subview addSubview:URLbutton];
        
        //tab on view
//        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//        [tap setNumberOfTapsRequired:1];
//        [subview addGestureRecognizer:tap];

        [self.recipeScrollView addSubview:subview];
        
    }
}

- (void)openRecipeURL:(UIButton *)sender {
    
    UIButton *button = (UIButton*) sender;
    NSLog(@"the tag of button is %ld", (long)button.tag);
    selectedRecipeIndex = button.tag;
    
    
    [self performSegueWithIdentifier:@"openRecipe" sender:self];
}

//- (void)handleTap:(UITapGestureRecognizer *)sender {
//    
//    if (sender.state == UIGestureRecognizerStateEnded)
//    {
//        UITapGestureRecognizer *button = (UITapGestureRecognizer*) sender;
//        NSLog(@"the tag of button is %ld", (long)button.tag);
//        selectedRecipeIndex = button.tag;
//        
//        
//        [self performSegueWithIdentifier:@"openRecipe" sender:self];
//    }
//    
//    
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"openRecipe"])
    {
        NSLog(@"Prepare for segue");
        
        RecipeDetailViewController *recipeDetail = segue.destinationViewController;
        
        recipeDetail.recipeURL = [[recipeArray objectAtIndex:selectedRecipeIndex] valueForKey:@"source_url"];
        
        recipeDetail.recipeTitle = [[recipeArray objectAtIndex:selectedRecipeIndex] valueForKey:@"title"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)addToShoppingList:(id)sender {
    
    if ([PFUser currentUser] != nil) {
        
        NSLog(@"logged in");
        PFUser *user = [PFUser currentUser];
        
        // Make a new post
        PFObject *shoppingItem = [PFObject objectWithClassName:@"ShoppingItem"];
        
        shoppingItem[@"itemID"] = [self.exam objectId];
        shoppingItem[@"user"] = user;
        [shoppingItem save];
        
        [self.addToShoppingList setTitle:@"Added!" forState:UIControlStateNormal];
        self.addToShoppingList.enabled = NO;
        
    } else {
        NSLog(@"Not logged in");
        
//        SignInViewController *signInVC = [[SignInViewController alloc] init];
//        
//       [self presentViewController:signInVC animated:YES completion:nil];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"loginScreen"];
        
        
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
       
        
        [self presentViewController:vc animated:YES completion:nil];
        
//        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Please Log in"
//                                                          message:@"To save a recipe, you must have an account with IPS and be logged in."
//                                                         delegate:nil
//                                                cancelButtonTitle:@"Cancel"
//                                                otherButtonTitles:@"Login with Facebook", nil];
//        [message show];
    }

}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    NSLog(@"index: %@", title);
    
    if(buttonIndex == 0)
    {
        NSLog(@"Loggin into FB");
        
        // The permissions requested from the user
        NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
        
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
                //            [self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
            } else {
                NSLog(@"User with facebook logged in!");
                //            [self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
            }
        }];
    }
}




@end
