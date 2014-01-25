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

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // This table displays items in the Todo class
        self.className = @"Product";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
    }
    return self;
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:@"Product"];
    
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
    
    // Configure the cell to show todo item with a priority at the bottom
    UILabel *productName;
    productName = (UILabel *)[cell viewWithTag:2];
    productName.text = [object objectForKey:@"name"];
    
    UIImage *productImage;
    productImage = (UIImage *)[cell viewWithTag:1];
    
    PFImageView *imageView = [[PFImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"..."]; // placeholder image
    imageView.file = (PFFile *)object[@"image"]; // remote image
    
    [imageView loadInBackground];
    
//    productImage = [UIImage imageWithData:imageView.file];


    
    return cell;
}
@end