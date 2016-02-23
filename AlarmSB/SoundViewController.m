//
//  SoundViewController.m
//  AlarmSB
//
//  Created by Vivek Srinivasan on 11/04/13.
//  Copyright (c) 2013 Vivek Srinivasan. All rights reserved.
//

#import "SoundViewController.h"
#import "ECSlidingViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface SoundViewController ()

@property (strong, nonatomic) NSArray *functions;

@end

@implementation SoundViewController

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
    
    self.functions = @[@"Sound1", @"Sound2", @"Sound3"];
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
    return 6;
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
    if(indexPath.row == 1){
        ViewController *bgController = (ViewController *)self.slidingViewController.topViewController;
        [bgController setSoundFile:@"Digital"];
        [bgController setSoundFileExtension:@"mp3"];
    }
    if(indexPath.row == 2){
        ViewController *bgController = (ViewController *)self.slidingViewController.topViewController;
        
        [bgController setSoundFile:@"Military"];
        [bgController setSoundFileExtension:@"mp3"];
    }
    if(indexPath.row == 3){
        ViewController *bgController = (ViewController *)self.slidingViewController.topViewController;
        
        [bgController setSoundFile:@"Fire"];
        [bgController setSoundFileExtension:@"mp3"];
    }
    if(indexPath.row == 4){
        ViewController *bgController = (ViewController *)self.slidingViewController.topViewController;
        
        [bgController setSoundFile:@"Birds"];
        [bgController setSoundFileExtension:@"mp3"];
    }
    if(indexPath.row == 5){
        ViewController *bgController = (ViewController *)self.slidingViewController.topViewController;
        
        [bgController setSoundFile:@"Groovy"];
        [bgController setSoundFileExtension:@"mp3"];
    }
    
    [self.slidingViewController resetTopViewWithAnimations:nil onComplete:nil];
    
    self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{   UIImage *defaultBg = [UIImage imageNamed:@"Blank.png"];
    UIImage *sound1Bg = [UIImage imageNamed:@"Digital.png"];
    UIImage *sound2Bg = [UIImage imageNamed:@"Military.png"];
    UIImage *sound3Bg = [UIImage imageNamed:@"Fire.png"];
    UIImage *sound4Bg = [UIImage imageNamed:@"Birds.png"];
    UIImage *sound5Bg = [UIImage imageNamed:@"Groovy.png"];
    
    UIImageView *defaultBgView = [[UIImageView alloc]initWithImage:defaultBg];
    UIImageView *sound1View = [[UIImageView alloc]initWithImage:sound1Bg];
    UIImageView *sound2View = [[UIImageView alloc]initWithImage:sound2Bg];
    UIImageView *sound3View = [[UIImageView alloc]initWithImage:sound3Bg];
    UIImageView *sound4View = [[UIImageView alloc]initWithImage:sound4Bg];
    UIImageView *sound5View = [[UIImageView alloc]initWithImage:sound5Bg];
    
    switch (indexPath.row) {
        case 0:
            cell.backgroundView = defaultBgView;
            break;
            
        case 1:
            cell.backgroundView = sound1View;
            break;
            
        case 2:
            cell.backgroundView = sound2View;
            break;
            
        case 3:
            cell.backgroundView = sound3View;
            break;
            
        case 4:
            cell.backgroundView = sound4View;
            break;
            
        case 5:
            cell.backgroundView = sound5View;
            break;
            
        default:
            break;
    }
    
    cell.backgroundColor = [UIColor clearColor];
}

@end
