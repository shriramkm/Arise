//
//  StateViewController.h
//  AlarmSB
//
//  Created by Vivek Srinivasan on 07/04/13.
//  Copyright (c) 2013 Vivek Srinivasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (copy) NSString *labelText;

@end
