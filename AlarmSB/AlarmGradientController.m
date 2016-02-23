//
//  AlarmGradientController.m
//  AlarmSB
//
//  Created by Vivek Srinivasan on 20/03/13.
//  Copyright (c) 2013 Vivek Srinivasan. All rights reserved.
//

#import "AlarmGradientController.h"
#import "ViewController.h"

@interface AlarmGradientController ()

@end

@implementation AlarmGradientController

@synthesize hour;
@synthesize hourLabel;
@synthesize minLabel;
@synthesize diffLabel;
@synthesize colon;
@synthesize colorCodeURL;

-(void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect nativeRect = { 0.f, 0.f, self.frame.size.width, self.frame.size.height };
    CGColorSpaceRef colourspace = CGColorSpaceCreateDeviceRGB();
    
    
    {
        NSBundle *bundle = [NSBundle mainBundle];
        NSURL *plistURL = [bundle URLForResource:colorCodeURL withExtension:@"plist"];
        self.ColorCodes = [NSDictionary dictionaryWithContentsOfURL:plistURL];
        
        NSArray *allTimes = [self.ColorCodes allKeys];
        
        NSArray *sortedTime = [allTimes sortedArrayUsingComparator:^(id firstObject,id secondObject) { return [((NSString *)firstObject) compare:((NSString*)secondObject) options:NSNumericSearch];}];
        self.timeStamp = sortedTime;
        NSString *selectedTime = [[NSString alloc] initWithFormat:@"%i",hour];
        self.colors = self.ColorCodes[selectedTime];
        
        {//To provide color to the label

            [hourLabel setTextColor:[UIColor colorWithRed:[[_colors objectAtIndex:9] floatValue] green:[[_colors objectAtIndex:10] floatValue] blue:[[_colors objectAtIndex:11] floatValue] alpha:1.0f]];
            
            [minLabel setTextColor:[UIColor colorWithRed:[[_colors objectAtIndex:9] floatValue] green:[[_colors objectAtIndex:10] floatValue] blue:[[_colors objectAtIndex:11] floatValue] alpha:1.0f]];
            
            [diffLabel setTextColor:[UIColor colorWithRed:[[_colors objectAtIndex:9] floatValue] green:[[_colors objectAtIndex:10] floatValue] blue:[[_colors objectAtIndex:11] floatValue] alpha:1.0f]];
            
            [colon setTextColor:[UIColor colorWithRed:[[_colors objectAtIndex:9] floatValue] green:[[_colors objectAtIndex:10] floatValue] blue:[[_colors objectAtIndex:11] floatValue] alpha:1.0f]];
            
        }
    }
    
    
    
    CGFloat bComponents[] = {[[_colors objectAtIndex:6] floatValue],[[_colors objectAtIndex:7] floatValue],[[_colors objectAtIndex:8] floatValue],1.0,[[_colors objectAtIndex:3] floatValue],[[_colors objectAtIndex:4] floatValue],[[_colors objectAtIndex:5] floatValue],1.0,[[_colors objectAtIndex:0] floatValue],[[_colors objectAtIndex:1] floatValue],[[_colors objectAtIndex:2] floatValue],1.0,0.0,0.0,0.0,1.0};
    
    CGFloat bGlocations[] = { 0.0, 0.45, 0.85, 1.0 };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colourspace, bComponents, bGlocations, 4);
    
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(nativeRect), CGRectGetMidY(nativeRect) + (CGRectGetHeight(nativeRect)*0.01));
    
    CGContextDrawRadialGradient(context, gradient, centerPoint, 0.0, centerPoint, CGRectGetHeight(nativeRect)/1.5, 0);
    
    CGGradientRelease(gradient);
    
    CGColorSpaceRelease(colourspace);
}

@end
