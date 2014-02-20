//
//  ShoppingListViewController.m
//  IPS
//
//  Created by Jon Paul Berti on 2/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "ShoppingListViewController.h"

@interface ShoppingListViewController ()

@property (strong, nonatomic)NSString *className;

@end

@implementation ShoppingListViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    UINavigationBar *navBar = self.navigationController.navigationBar;
    //    UIImage *image = [UIImage imageNamed:@"peak-thumbnail.png"];
    //    [navBar setBackgroundImage:image forBarMetrics:(UIBarMetricsDefault)];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self loadObjects];
}


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        
        self.className = @"Product";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
    }
    return self;
}

- (PFQuery *)queryForTable {
    
    PFQuery *listQuery = [PFQuery queryWithClassName:@"ShoppingItem"];
    [listQuery whereKey:@"user" equalTo: [PFUser currentUser]];
//    [seasonQuery whereKey:@"quality" greaterThan:[NSNumber numberWithInt:3]];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Product"];

    [query whereKey:@"objectId" matchesKey:@"itemID" inQuery:listQuery];
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
    return query;
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
    
    
    UILabel *productName;
    productName = (UILabel *)[cell viewWithTag:2];
    //    productName.numberOfLines = 0;
    //    [productName sizeToFit];
    productName.text = [object objectForKey:@"name"];
    
    UIImageView *productImage;
    productImage = (UIImageView *)[cell viewWithTag:1];
    
    PFFile *imageFile = [object objectForKey:@"image"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        if (!error) {
            UIImage *MyPicture = [UIImage imageWithData:data];
            productImage.image = MyPicture;
        }
    }];
    [productImage setClipsToBounds:YES];
    
    return cell;
}




@end