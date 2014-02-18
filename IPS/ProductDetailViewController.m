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
    
    NSDictionary *recipeDictionary = [recipes getRecipes: [self.exam objectForKey:@"name"]];
    
    recipeArray = [recipeDictionary objectForKey:@"recipes"];
    NSLog(@"from controller, the recipes are: %@", recipeArray);

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

        [self.recipeScrollView addSubview:subview];
        
    }
}

- (void)openRecipeURL:(UIButton *)sender {
    
    UIButton *button = (UIButton*) sender;
    NSLog(@"the tag of button is %ld", (long)button.tag);
    selectedRecipeIndex = button.tag;
    
    
    [self performSegueWithIdentifier:@"openRecipe" sender:self];
}

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



@end
