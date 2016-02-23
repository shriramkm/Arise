//
//  AlertViewController.m
//  AlarmSB
//
//  Created by Vivek Srinivasan on 11/04/13.
//  Copyright (c) 2013 Vivek Srinivasan. All rights reserved.
//

#import "AlertViewController.h"
#import "ECSlidingViewController.h"

@interface AlertViewController ()

@property (strong, nonatomic) NSArray *functions;

@end

@implementation AlertViewController

@synthesize functions;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.functions = @[@"", @"Sound Only", @"Vibrate Only", @"Sound + Vibrate"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        if(indexPath.row == 0){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.userInteractionEnabled = NO;
        }
        else{
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
    }
    else{
        if(indexPath.row == 0){
            cell.userInteractionEnabled = NO;
        }
    }
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[[UIColor alloc]initWithRed:0.33f green:0.33f blue:0.33f alpha:0.5f]];
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.slidingViewController resetTopViewWithAnimations:nil onComplete:nil];
    
    self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{   UIImage *defaultBg = [UIImage imageNamed:@"Blank.png"];
    UIImage *soundOnlyBg = [UIImage imageNamed:@"Sound Only.png"];
    UIImage *vibrateOnlyBg = [UIImage imageNamed:@"Vibrate Only.png"];
    UIImage *bothBg = [UIImage imageNamed:@"Both.png"];
    
    UIImageView *defaultBgView = [[UIImageView alloc]initWithImage:defaultBg];
    UIImageView *soundOnlyBgView = [[UIImageView alloc]initWithImage:soundOnlyBg];
    UIImageView *vibrateOnlyBgView = [[UIImageView alloc]initWithImage:vibrateOnlyBg];
    UIImageView *bothBgView = [[UIImageView alloc]initWithImage:bothBg];
    
    switch (indexPath.row) {
        case 0:
            cell.backgroundView = defaultBgView;
            break;
            
        case 1:
            cell.backgroundView = soundOnlyBgView;
            break;
            
        case 2:
            cell.backgroundView = vibrateOnlyBgView;
            break;
            
        case 3:
            cell.backgroundView = bothBgView;
            break;
            
        default:
            break;
    }
    
    cell.backgroundColor = [UIColor clearColor];
}

@end
