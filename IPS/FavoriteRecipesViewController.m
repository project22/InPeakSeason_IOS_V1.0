//
//  FavoriteRecipesViewController.m
//  IPS
//
//  Created by Jon Paul Berti on 2/9/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "FavoriteRecipesViewController.h"

@interface FavoriteRecipesViewController ()

@property (strong, nonatomic)NSString *className;

@end

@implementation FavoriteRecipesViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        
        self.className = @"FavRecipe";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PFQuery *)queryForTable {
    if ([PFUser currentUser] != nil) {
        
        PFQuery *listQuery = [PFQuery queryWithClassName:@"FavRecipe"];
        [listQuery whereKey:@"user" equalTo: [PFUser currentUser]];
        return listQuery;
     
        
    } else {
        NSLog(@"Not logged in");
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"loginScreen"];
        
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        
        [self presentViewController:vc animated:YES completion:nil];
        
        // This is a hack.  Fix it!
        PFQuery *query = [PFQuery queryWithClassName:@"FavRecipe"];
        [query whereKey:@"objectId" equalTo:@""];
        return query;
        
    }
    
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    
    
    UILabel *recipeName;
    recipeName = (UILabel *)[cell viewWithTag:2];

    recipeName.text = [object objectForKey:@"title"];
    
    UIImageView *recipeImage;
    recipeImage = (UIImageView *)[cell viewWithTag:1];
    
    PFFile *imageFile = [object objectForKey:@"recipe_image"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        if (!error) {
            UIImage *MyPicture = [UIImage imageWithData:data];
            recipeImage.image = MyPicture;
        }
    }];
    [recipeImage setClipsToBounds:YES];
    
    return cell;
}



- (IBAction)deleteFavorites:(id)sender {
    
    
}
@end
