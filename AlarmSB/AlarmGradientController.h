//
//  AlarmGradientController.h
//  AlarmSB
//
//  Created by Vivek Srinivasan on 20/03/13.
//  Copyright (c) 2013 Vivek Srinivasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmGradientController : UIView

@property (strong, nonatomic) NSDictionary *ColorCodes;
@property (strong, nonatomic) NSArray *timeStamp;
@property (strong, nonatomic) NSArray *colors;
@property int hour;
@property UILabel *hourLabel;
@property UILabel *minLabel;
@property UILabel *diffLabel;
@property UILabel *colon;
@property NSString *colorCodeURL;

@end
