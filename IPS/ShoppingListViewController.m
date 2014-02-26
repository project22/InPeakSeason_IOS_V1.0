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
{
    NSArray *shoppingList;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    UINavigationBar *navBar = self.navigationController.navigationBar;
    //    UIImage *image = [UIImage imageNamed:@"peak-thumbnail.png"];
    //    [navBar setBackgroundImage:image forBarMetrics:(UIBarMetricsDefault)];
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //add code here for when you hit delete
        NSLog(@"deleting shopping item");
        NSLog(@"shoppingList = %@", shoppingList);
        PFObject *object = [shoppingList objectAtIndex:indexPath.row];
        
        
        //        NSLog(@"index path: %@", indexPath);
//        PFObject *object = [PFObject objectWithoutDataWithClassName:@"ShoppingItem"
//                                                           objectId:@"efgh"];
        [object delete];
        [self.tableView reloadData];
        NSLog(@"Object: %@", object);
        
    }
}


-(void)viewWillAppear:(BOOL)animated {
    [self loadObjects];
}


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        
        self.className = @"ShoppingItem";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
    }
    return self;
}

- (PFQuery *)queryForTable {
    
    if ([PFUser currentUser] != nil) {
        
        
        PFQuery *listQuery = [PFQuery queryWithClassName:@"ShoppingItem"];
        [listQuery whereKey:@"user" equalTo: [PFUser currentUser]];
        //    [seasonQuery whereKey:@"quality" greaterThan:[NSNumber numberWithInt:3]];
        
        
        [listQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                NSLog(@"%@", objects);
                
                shoppingList = objects;
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
        
        PFQuery *query = [PFQuery queryWithClassName:@"Product"];
        
        [query whereKey:@"objectId" matchesKey:@"itemID" inQuery:listQuery];
        
        // If no objects are loaded in memory, we look to the cache
        // first to fill the table and then subsequently do a query
        // against the network.
        if ([self.objects count] == 0) {
            query.cachePolicy = kPFCachePolicyCacheThenNetwork;
        }
        
        [query orderByDescending:@"createdAt"];
        [query whereKey:@"objectId" matchesKey:@"itemID" inQuery:listQuery];
        
//        shoppingList = listQuery;
        return query;
        

        
    } else {
        NSLog(@"Not logged in");
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"loginScreen"];
        
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        
        [self presentViewController:vc animated:YES completion:nil];
        
        
        PFQuery *query = [PFQuery queryWithClassName:@"Product"];
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
    
    
    UILabel *productName;
    productName = (UILabel *)[cell viewWithTag:2];
    //    productName.numberOfLines = 0;
    //    [productName sizeToFit];
    productName.text = [object objectForKey:@"name"];
    
    UIImageView *productImage;
    productImage = (UIImageView *)[cell viewWithTag:1];
    [productImage.layer setCornerRadius:29.0];
    
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






- (IBAction)deleteList:(id)sender {
    
    if ([PFUser currentUser] != nil) {
        
        
        PFQuery *listQuery = [PFQuery queryWithClassName:@"ShoppingItem"];
        [listQuery whereKey:@"user" equalTo: [PFUser currentUser]];

        
        //destroy all these records
//        for (PFObject *listItem in listQuery) {
//            [listItem deleteInBackground];
//        }


        
        
        
    }
    
    PFQuery *listQuery = [PFQuery queryWithClassName:@"ShoppingItem"];
    [listQuery whereKey:@"user" equalTo: [PFUser currentUser]];
    
    NSLog(@"%ld", (long)listQuery.countObjects);
    
    
    

}
@end
