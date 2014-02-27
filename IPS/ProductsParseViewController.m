//
//  ProductsParseViewController.m
//  IPS
//
//  Created by Jon Paul Berti on 1/24/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "ProductsParseViewController.h"

@interface ProductsParseViewController ()

@property (strong, nonatomic)NSString *className;

@end

@implementation ProductsParseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"peak_logo.png"]]];
    
    self.navigationItem.leftBarButtonItem = item;
    
    [self.view setBackgroundColor:[UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:1.0]];
}


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

- (PFQuery *)queryForTable {

    PFQuery *seasonQuery = [PFQuery queryWithClassName:@"Season"];
    [seasonQuery whereKey:@"month" equalTo:@"2"];
    [seasonQuery whereKey:@"quality" greaterThan:[NSNumber numberWithInt:0]];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Product"];
    [query whereKey:@"Season" matchesQuery:seasonQuery];
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
//    [query includeKey:@"Season"];
    
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
    
    
    
    NSLog(@"The PFObject is %@", object);
    
//    
    PFRelation *studentsRelation = [object relationforKey:@"Season"];
    PFQuery *query = studentsRelation.query;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d season.", objects.count);
            // Do something with the found objects
            NSString *rating =  [objects[0] valueForKey:@"quality"];
            NSLog(@"Rating %@", rating);
            
            //build the cell
//            UILabel *ratingLabel;
//            ratingLabel = (UILabel *)[cell viewWithTag:7];
//            ratingLabel.text = rating;
            

            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    

    UILabel *productName;
    productName = (UILabel *)[cell viewWithTag:2];

    productName.text = [object objectForKey:@"name"];
    
    UIImageView *productImage;
    productImage = (UIImageView *)[cell viewWithTag:1];
    
    
    // figure out how this works, and apply above.
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Check that a new transition has been requested to the DetailViewController and prepares for it
    if ([segue.identifier isEqualToString:@"toProductDetail"]){
        
        // Capture the object (e.g. exam) the user has selected from the list
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        
        // Set destination view controller to DetailViewController to avoid the NavigationViewController in the middle (if you have it embedded into a navigation controller, if not ignore that part)

        ProductDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.exam = object;
    }
}




@end