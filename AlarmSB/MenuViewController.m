//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Kyle Begeman on 1/13/13.
//  Copyright (c) 2013 Indee Box LLC. All rights reserved.
//

#import "MenuViewController.h"
#import "ECSlidingViewController.h"

@interface MenuViewController ()

@property (strong, nonatomic) NSArray *funcList;

@end

@implementation MenuViewController

@synthesize funcList;


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
    
    [self.slidingViewController setAnchorLeftRevealAmount:200.0f];
    self.slidingViewController.underRightWidthLayout = ECFullWidth;
    [self.slidingViewController setAnchorRightRevealAmount:120.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    
    self.funcList = @[@"",@"alertView", @"modeView", @"settingView", @"soundView", @"themeView"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 60.0;
            break;
            
        case 4:
            return 60.0;
            break;
            
        default:
            return 60.0;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *tableIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        if(indexPath.row == 0){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
            cell.userInteractionEnabled = NO;
        }
        else{
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
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
    switch (indexPath.row) {
        case 1:
            self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"alertView"];
            break;
            
        case 2:
            self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"modeView"];
            break;
            
        case 3:
            self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"settingView"];
            break;
            
        case 4:
            self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"soundView"];
            break;
            
        case 5:
            self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"themeView"];
            break;
            
        default:
            break;
    }
    NSString *identifier = [NSString stringWithFormat:@"%@", [self.funcList objectAtIndex:indexPath.row]];
    
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECLeft animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
    }];
    
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{   UIImage *defaultBg = [UIImage imageNamed:@"Blank.png"];
    UIImage *alertsBg = [UIImage imageNamed:@"Alerts.png"];
    UIImage *modesBg = [UIImage imageNamed:@"Modes.png"];
    UIImage *settingsBg = [UIImage imageNamed:@"Settings.png"];
    UIImage *soundsBg = [UIImage imageNamed:@"Sound.png"];
    UIImage *themesBg = [UIImage imageNamed:@"Themes.png"];
    
    UIImageView *defaultBgView = [[UIImageView alloc]initWithImage:defaultBg];
    UIImageView *alertsBgView = [[UIImageView alloc]initWithImage:alertsBg];
    UIImageView *modesBgView = [[UIImageView alloc]initWithImage:modesBg];
    UIImageView *settingsBgView = [[UIImageView alloc]initWithImage:settingsBg];
    UIImageView *soundsBgView = [[UIImageView alloc]initWithImage:soundsBg];
    UIImageView *themesBgView = [[UIImageView alloc]initWithImage:themesBg];
    
    switch (indexPath.row) {
        case 0:
            cell.backgroundView = defaultBgView;
            break;
        
        case 1:
            cell.backgroundView = alertsBgView;
            break;
            
        case 2:
            cell.backgroundView = modesBgView;
            break;
            
        case 3:
            cell.backgroundView = settingsBgView;
            break;
            
        case 4:
            cell.backgroundView = soundsBgView;
            break;
            
        case 5:
            cell.backgroundView = themesBgView;
            break;
        
        default:
            break;
    }
    
    cell.backgroundColor = [UIColor clearColor];
}

@end
