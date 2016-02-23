//
//  StateViewController.m
//  AlarmSB
//
//  Created by Vivek Srinivasan on 07/04/13.
//  Copyright (c) 2013 Vivek Srinivasan. All rights reserved.
//

#import "StateViewController.h"
#import "ECSlidingViewController.h"
#import "ViewController.h"

@interface StateViewController ()

@end

@implementation StateViewController

@synthesize stateLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    stateLabel.text = @"ON";
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
