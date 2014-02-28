//
//  MarketsViewContainerController.h
//  In Peak Season
//
//  Created by Jon Paul Berti on 2/27/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketsMapViewController.h"

@interface MarketsViewContainerController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *marketView;

- (IBAction)openListView:(id)sender;



@end
