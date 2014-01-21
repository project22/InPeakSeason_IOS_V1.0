//
//  MarketsViewController.h
//  IPS
//
//  Created by Jon Paul Berti on 1/20/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Market.h"
#import "MarketDetailViewController.h"

@interface MarketsViewController : UIViewController <CLLocationManagerDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *marketsTable;


@end
