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
        
        self.className = @"Product";
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
    PFQuery *listQuery = [PFQuery queryWithClassName:@"Product"];
    
    return listQuery;
}

- (IBAction)addComment:(id)sender {
    if ([PFUser currentUser] != nil) {
        
        NSLog(@"logged in");
        // present popup;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"addComment"];
        
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:vc animated:YES completion:nil];
        
        
        
    } else {
        NSLog(@"Not logged in");
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"loginScreen"];
        
        
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        
        
        [self presentViewController:vc animated:YES completion:nil];
        
        
    }
    
}

@end
