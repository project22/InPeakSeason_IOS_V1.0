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
    NSString *selectedRecipeURL;
    NSString *selectedRecipeTitle;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    

    NSLog(@"Object ID %@", [_exam objectId] );
    
    self.productNameLabel.text = [self.exam objectForKey:@"name"];
    self.navigationItem.title = [self.exam objectForKey:@"name"];
    
    
    PFFile *imageFile = [self.exam objectForKey:@"image"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        if (!error) {
            UIImage *MyPicture = [UIImage imageWithData:data];
            self.productImage.image = MyPicture;
            
        }
    }];
    [self.productImage setClipsToBounds:YES];
    
    
    
    Recipe *recipes = [[Recipe alloc] init];
    
    // make this asycronous
    NSDictionary *recipeDictionary = [recipes getRecipes: [self.exam objectForKey:@"name"]];
    
    recipeArray = [recipeDictionary objectForKey:@"recipes"];

    //output recipes into scroll view
    self.recipeScrollView.contentSize = CGSizeMake(self.recipeScrollView.frame.size.width * recipeArray.count, self.recipeScrollView.frame.size.height);
    
    for (int i = 0; i < recipeArray.count; i++) {
        CGRect frame;
        frame.origin.x = self.recipeScrollView.frame.size.width * i;
        frame.origin.y = 0;

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
        
        
        UILabel *recipeTitle =[[UILabel alloc] initWithFrame:CGRectMake(0,self.recipeScrollView.frame.size.height - 50, self.recipeScrollView.frame.size.width , 50)];

        recipeTitle.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        recipeTitle.textAlignment = NSTextAlignmentLeft;
        
        NSString *recipeName = [[recipeArray objectAtIndex:i] valueForKey:@"title"];
       
        
        recipeTitle.text =  [recipeName stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        
        [subview addSubview:recipeTitle];
        
        
        UIButton *URLbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [URLbutton setFrame:CGRectMake(220, 10, 40, 40)];
        
        UIImage *ViewRecipe =  [UIImage imageNamed:@"search-50.png"];
        [URLbutton setImage:ViewRecipe forState:UIControlStateNormal];
        [URLbutton setTintColor:[UIColor whiteColor]];
        [URLbutton setContentMode:UIViewContentModeScaleAspectFill];
        
        URLbutton.accessibilityValue = [recipeArray objectAtIndex:i];
        
        [URLbutton addTarget:self action:@selector(openRecipeURL:) forControlEvents:UIControlEventTouchUpInside];
        [subview addSubview:URLbutton];
        
        //tab on view
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(handleTap:)];

        doubleTap.accessibilityValue = [recipeArray objectAtIndex:i];
        doubleTap.numberOfTapsRequired = 2;
        [subview addGestureRecognizer:doubleTap];

        [self.recipeScrollView addSubview:subview];
        
        //favoriting recipe button
        UIButton *favButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [favButton setFrame:CGRectMake(270, 8, 40, 40)];
        
        UIImage *favRecipe =  [UIImage imageNamed:@"like-50.png"];
        [favButton setImage:favRecipe forState:UIControlStateNormal];
        [favButton setTintColor:[UIColor whiteColor]];
        [favButton setContentMode:UIViewContentModeScaleAspectFill];
        
        favButton.accessibilityValue = [recipeArray objectAtIndex:i];
        
        [favButton addTarget:self action:@selector(facRecipe:) forControlEvents:UIControlEventTouchUpInside];
        [subview addSubview:favButton];
        
    }
}

- (void)facRecipe:(UIButton *)sender {
    NSLog(@"favoriting");
    if ([PFUser currentUser] != nil) {
        
        NSLog(@"logged in");
        PFUser *user = [PFUser currentUser];
        
        // Make a new post
        PFObject *favRecipe = [PFObject objectWithClassName:@"FavRecipe"];
        
        
        favRecipe[@"title"] = [sender.accessibilityValue valueForKey:@"title"];
        favRecipe[@"source_url"] = [sender.accessibilityValue valueForKey:@"source_url"];
        favRecipe[@"user"] = user;
        
        
        
        NSURL *pictureURL = [NSURL URLWithString:[sender.accessibilityValue valueForKey:@"image_url"]];
        
        //convert this to a picture for parse and upload
        
        NSData *picData = [NSData dataWithContentsOfURL:pictureURL];
        PFFile *picFile = [PFFile fileWithData:picData];
        favRecipe[@"recipe_image"] = picFile;
        
        [favRecipe save];
        
        
    } else {
        NSLog(@"Not logged in");
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"loginScreen"];
        
        
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        
        
        [self presentViewController:vc animated:YES completion:nil];
        
        
    }
}

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        // handling code
        selectedRecipeURL = [NSString stringWithFormat:@"%@", [sender.accessibilityValue valueForKey:@"source_url"]];
        selectedRecipeTitle = [NSString stringWithFormat:@"%@", [sender.accessibilityValue valueForKey:@"title"]];
        
        NSLog(@"tapped: %@", sender.accessibilityValue);
        [self performSegueWithIdentifier:@"openRecipe" sender:self];
    }
}

- (void)openRecipeURL:(UIButton *)sender {
    

    
    selectedRecipeURL = [NSString stringWithFormat:@"%@", [sender.accessibilityValue valueForKey:@"source_url"]];
    selectedRecipeTitle = [NSString stringWithFormat:@"%@", [sender.accessibilityValue valueForKey:@"title"]];
    
    NSLog(@"tapped: %@", sender.accessibilityValue);
    [self performSegueWithIdentifier:@"openRecipe" sender:self];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"openRecipe"])
    {
        NSLog(@"Prepare for segue");
        
        RecipeDetailViewController *recipeDetail = segue.destinationViewController;
        
        recipeDetail.recipeURL = selectedRecipeURL;
        recipeDetail.recipeTitle = selectedRecipeTitle;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)addToShoppingList:(id)sender {
    
    if ([PFUser currentUser] != nil) {
        
        NSLog(@"Saving item to shopping list");
        PFUser *user = [PFUser currentUser];
        
        // Make a new post
        PFObject *shoppingItem = [PFObject objectWithClassName:@"ShoppingItem"];
        
        shoppingItem[@"itemID"] = [self.exam objectId];
        shoppingItem[@"user"] = user;
        shoppingItem[@"complete"] = [NSNumber numberWithBool:NO];
        
        // check to see if itemID already in DB for this user
        PFQuery *query = [PFQuery queryWithClassName:@"ShoppingItem"];
        [query whereKey:@"itemID" equalTo:[self.exam objectId]];
        [query whereKey:@"user" equalTo:user];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                if (objects.count <= 0) {
                    //add the new record.
                    [shoppingItem saveInBackground];
                } else {
                    NSLog(@"Shopping item already exists");
                }
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
        
        
        
        [self.addToShoppingList setTitle:@"Added!" forState:UIControlStateNormal];
        self.addToShoppingList.enabled = NO;
        
    } else {
        NSLog(@"Not logged in");
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"loginScreen"];
        
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
       
        [self presentViewController:vc animated:YES completion:nil];
        
    }

}







@end
