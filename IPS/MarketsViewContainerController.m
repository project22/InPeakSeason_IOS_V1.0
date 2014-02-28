//
//  MarketsViewContainerController.m
//  In Peak Season
//
//  Created by Jon Paul Berti on 2/27/14.
//  Copyright (c) 2014 JPBerti. All rights reserved.
//

#import "MarketsViewContainerController.h"

@interface MarketsViewContainerController ()

@end

@implementation MarketsViewContainerController


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




- (IBAction)openListView:(id)sender {
    NSLog(@"performing segue to list view");
    [self performSegueWithIdentifier:@"toListView" sender:self];
}
@end
