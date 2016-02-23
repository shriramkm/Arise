//
//  ModeViewController.m
//  AlarmSB
//
//  Created by Vivek Srinivasan on 11/04/13.
//  Copyright (c) 2013 Vivek Srinivasan. All rights reserved.
//

#import "ModeViewController.h"
#import "ECSlidingViewController.h"

@interface ModeViewController ()

@property (strong, nonatomic) NSArray *functions;

@end

@implementation ModeViewController

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

    self.functions = @[@"Alarm", @"Timer"];
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
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
    if(indexPath.row==1){
        ViewController *bgController = (ViewController *)self.slidingViewController.topViewController;
        [bgController setAlarmMode:@"Alarm"];
        [bgController.bg setNeedsDisplay];
    }
    else if(indexPath.row==2){
        ViewController *bgController = (ViewController *)self.slidingViewController.topViewController;
        [bgController setAlarmMode:@"Timer"];
        [bgController.bg setNeedsDisplay];
    }
    
    [self.slidingViewController resetTopViewWithAnimations:nil onComplete:nil];
    
    self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{   UIImage *defaultBg = [UIImage imageNamed:@"Blank.png"];
    UIImage *alarmBg = [UIImage imageNamed:@"Alarm.png"];
    UIImage *timerBg = [UIImage imageNamed:@"Timer.png"];
    
    UIImageView *defaultBgView = [[UIImageView alloc]initWithImage:defaultBg];
    UIImageView *alarmBgView = [[UIImageView alloc]initWithImage:alarmBg];
    UIImageView *timerBgView = [[UIImageView alloc]initWithImage:timerBg];
    
    switch (indexPath.row) {
        case 0:
            cell.backgroundView = defaultBgView;
            break;
            
        case 1:
            cell.backgroundView = alarmBgView;
            break;
            
        case 2:
            cell.backgroundView = timerBgView;
            break;
            
        default:
            break;
    }
    
    cell.backgroundColor = [UIColor clearColor];
}


@end
