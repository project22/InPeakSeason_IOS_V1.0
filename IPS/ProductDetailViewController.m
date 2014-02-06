//
//  ProductDetailViewController.m
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *recipeScrollView;


@end

@implementation ProductDetailViewController {
    NSArray *recipeArray;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.productNameLabel.text = [self.exam objectForKey:@"name"];
    self.navigationItem.title = [self.exam objectForKey:@"name"];
    self.triedProductQuestion.text = [NSString stringWithFormat:@"Tried local %@ lately?", [self.exam objectForKey: @"name"]];
    
    Recipe *recipes = [[Recipe alloc] init];
    
    NSDictionary *recipeDictionary = [recipes getRecipes: [self.exam objectForKey:@"name"]];
    
    recipeArray = [recipeDictionary objectForKey:@"recipes"];
    NSLog(@"from controller, the recipes are: %@", recipeArray);

    //output recipes into scroll view
   
    
    for (int i = 0; i < recipeArray.count; i++) {
        CGRect frame;
        frame.origin.x = self.recipeScrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.recipeScrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        
        NSString * recipeImageURL = [NSString stringWithFormat:@"%@", [[recipeArray objectAtIndex:i] valueForKey:@"image_url"]];
        NSURL *imageURL = [NSURL URLWithString: recipeImageURL];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        UIImageView *recipeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.recipeScrollView.frame.size.width, self.recipeScrollView.frame.size.height)];
        [recipeImage setImage:image];
        recipeImage.contentMode = UIViewContentModeScaleAspectFill;
        [recipeImage setClipsToBounds:YES];
        [subview addSubview:recipeImage];
        
        UILabel *recipeTitle =[[UILabel alloc] initWithFrame:CGRectMake(20,200,200,40)];
        recipeTitle.text = [[recipeArray objectAtIndex:i] valueForKey:@"title"];
        
        [subview addSubview:recipeTitle];
    
//        subview.backgroundColor = [colors objectAtIndex:i];
        [self.recipeScrollView addSubview:subview];
        
       
    }
    
     self.recipeScrollView.contentSize = CGSizeMake(self.recipeScrollView.frame.size.width * recipeArray.count, self.recipeScrollView.frame.size.height);
    

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
