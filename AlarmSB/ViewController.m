//
//  ViewController.m
//  AlarmSB
//
//  Created by Vivek Srinivasan on 20/03/13.
//  Copyright (c) 2013 Vivek Srinivasan. All rights reserved.
//

#import "ViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "AlertViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize hourLabel;
@synthesize minLabel;
@synthesize diffLabel;
@synthesize colon;
@synthesize hourTrack;
@synthesize minTrack;
@synthesize swipe;
@synthesize bg;
@synthesize hourDec;
@synthesize hourInc;
@synthesize minDec;
@synthesize minInc;
@synthesize counter;

@synthesize setAlarm;
@synthesize stateFrame;
@synthesize alarmState;
@synthesize setHour;
@synthesize setMinute;
@synthesize alarmMode;
@synthesize repeatingTimer;
@synthesize diffTimer;
@synthesize alarmTimer;
@synthesize alarmTriggerTimer;
@synthesize diffHour;
@synthesize diffMin;
@synthesize diffSeconds;
@synthesize timeElapsed;
@synthesize alarmSound;
@synthesize soundFile;
@synthesize soundFileExtension;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    swipe = 0;
    [bg setHour:12];
    self.hourLabel.text = [NSString stringWithFormat:@"%2d",12];
    [bg setHourLabel:hourLabel];
    [bg setMinLabel:minLabel];
    [bg setDiffLabel:diffLabel];
    [bg setColon:colon];
    [bg setColorCodeURL:@"ColorCodes"];
    [self setAlarmMode:@"Alarm"];
    self.timeElapsed = 0;
    self.soundFile = @"Fire";
    self.soundFileExtension = @"mp3";
    
    //stateLabel.text = @"OFF";
    //stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(-100,0,100,self.view.frame.size.height)];
    //[stateLabel setBackgroundColor:[[UIColor alloc] initWithRed:0.85 green:0.85 blue:0.85 alpha:0.66]];
    
    alarmState = NO;
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"AlarmState"];
    }
    
    if (![self.slidingViewController.underRightViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    [self.slidingViewController setVc:self];
    self.slidingViewController.panGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)reset{
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    swipe = 0;
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!alarmState){
        swipe++;
        if(swipe%3==0){
            CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
            CGPoint prevtouchPoint = [[touches anyObject] previousLocationInView:self.view];
            if(swipe%9==0){
                if (touchPoint.x > hourTrack.frame.origin.x &&
                    touchPoint.x < hourTrack.frame.origin.x + hourTrack.frame.size.width &&
                    touchPoint.y > hourTrack.frame.origin.y &&
                    touchPoint.y < hourTrack.frame.origin.y + hourTrack.frame.size.height){
                    int hr = ([self.hourLabel.text intValue]%24);
                    if(prevtouchPoint.y < touchPoint.y){
                        if(hr+1==24){
                            hr = -1;
                        }
                        self.hourLabel.text = [[NSString alloc]initWithFormat:@"%02d",++hr];
                    }
                    else if(prevtouchPoint.y > touchPoint.y){
                        hr--;
                        if(hr==24){
                            hr = 0;
                        }
                        if(hr<0){
                            hr+=24;
                        }
                        self.hourLabel.text = [[NSString alloc]initWithFormat:@"%02d",hr];
                    }
                    [bg setNeedsDisplayInRect:bg.frame];
                }
            }
            if (touchPoint.x > minTrack.frame.origin.x &&
                touchPoint.x < minTrack.frame.origin.x + minTrack.frame.size.width &&
                touchPoint.y > minTrack.frame.origin.y &&
                touchPoint.y < minTrack.frame.origin.y + minTrack.frame.size.height){
                int min = ([self.minLabel.text intValue]%60);
                if(prevtouchPoint.y < touchPoint.y){
                    min=(++min)%60;
                    self.minLabel.text = [[NSString alloc]initWithFormat:@"%02d",min];
                    if(min==0){
                    }
                }
                else if(prevtouchPoint.y > touchPoint.y){
                    min--;
                    if(min<=0){
                        min+=60;
                    }
                    min%=60;
                    self.minLabel.text = [[NSString alloc]initWithFormat:@"%02d",min];
                }
            }
        }
        [bg setHour:[hourLabel.text intValue]];
        [bg setNeedsDisplayInRect:bg.frame];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!alarmState){
        [bg setHour:[hourLabel.text intValue]];
        [bg setNeedsDisplayInRect:bg.frame];
        if(swipe==0){
            CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
            if (touchPoint.x > hourDec.frame.origin.x &&
                touchPoint.x < hourDec.frame.origin.x + hourDec.frame.size.width &&
                touchPoint.y > hourDec.frame.origin.y &&
                touchPoint.y < hourDec.frame.origin.y + hourDec.frame.size.height){
                int hr = [self.hourLabel.text intValue];
                if(hr-1<0){
                    hr+=24;
                }
                hr = (hr-1)%24;
                self.hourLabel.text = [[NSString alloc]initWithFormat:@"%02d",hr];;
            }
            else if (touchPoint.x > hourInc.frame.origin.x &&
                     touchPoint.x < hourInc.frame.origin.x + hourInc.frame.size.width &&
                     touchPoint.y > hourInc.frame.origin.y &&
                     touchPoint.y < hourInc.frame.origin.y + hourInc.frame.size.height){
                int hr = [self.hourLabel.text intValue];
                hr = (hr+1)%24;
                self.hourLabel.text = [[NSString alloc]initWithFormat:@"%02d",hr];;
            }
            else if (touchPoint.x > minDec.frame.origin.x &&
                     touchPoint.x < minDec.frame.origin.x + minDec.frame.size.width &&
                     touchPoint.y > minDec.frame.origin.y &&
                     touchPoint.y < minDec.frame.origin.y + minDec.frame.size.height){
                int min = [self.minLabel.text intValue];
                if(min-1<0){
                    min+=60;
                }
                min = (min-1)%60;
                self.minLabel.text = [[NSString alloc]initWithFormat:@"%02d",min];;
            }
            else if (touchPoint.x > minInc.frame.origin.x &&
                     touchPoint.x < minInc.frame.origin.x + minInc.frame.size.width &&
                     touchPoint.y > minInc.frame.origin.y &&
                     touchPoint.y < minInc.frame.origin.y + minInc.frame.size.height){
                int min = [self.minLabel.text intValue];
                min = (min+1)%60;
                self.minLabel.text = [[NSString alloc]initWithFormat:@"%02d",min];;
            }
            [bg setHour:[hourLabel.text intValue]];
            [bg setNeedsDisplayInRect:bg.frame];
        }
    }
    else{
        
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)setAlarmTime{
    
    
    NSDate *now = [[NSDate alloc]init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(kCFCalendarUnitHour | kCFCalendarUnitMinute) fromDate:now];
    NSInteger currentHour = [components hour];
    NSInteger currentMinute = [components minute];
    self.setHour = [hourLabel.text integerValue];
    self.setMinute = [minLabel.text integerValue];
    
    if([alarmMode isEqual:@"Alarm"]){
        if(self.setHour>=currentHour){
            diffHour = self.setHour-currentHour;
        }
        else{
            diffHour = 24-(currentHour-self.setHour);
            if (diffHour == 24 && diffMin < self.setMinute) {
                diffHour = 0;
            }
        }
        
        
        if(currentMinute>setMinute){
            diffHour--;
            diffMin = 60-(currentMinute-setMinute);
        }
        else{
            diffMin = setMinute-currentMinute;
        }
        
        diffLabel.alpha = 1;
        
        
        NSString *path = [[NSBundle mainBundle] pathForResource:self.soundFile ofType:self.soundFileExtension];
        NSURL* url = [NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID( (CFURLRef)objc_unretainedPointer(url), &alarmSound);
        
        
        now = [[NSDate alloc]init];
        calendar = [NSCalendar currentCalendar];
        components = [calendar components:(kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond) fromDate:now];
        
        NSInteger currentSeconds = [components second];
        self.diffSeconds = 60-currentSeconds;
        self.alarmTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateAlarmLabel:) userInfo:nil repeats:YES];
        
        if(self.setHour==currentHour && self.setMinute<currentMinute){
            diffHour = 23;
        }
        diffMin--;
        NSString *diffLabelText = [[NSString alloc] initWithFormat:@"%02d:%02d:%02d Hours Left",(diffMin==-1?((diffSeconds==0)?12:diffHour-1):diffHour),((diffMin==-1)?((diffSeconds==0)?0:59):diffMin),diffSeconds];
        diffLabel.text = diffLabelText;
        
        /*self.alarmTriggerTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(checkAlarmExpiry:) userInfo:nil repeats:YES];
        
         [UIView beginAnimations:nil context:NULL];
         [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
         [UIView setAnimationDuration:7.0f];
         diffLabel.alpha = 0;
         [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
         [UIView commitAnimations];*/
        
    }
    else if([alarmMode isEqual:@"Timer"]){
        [self setTimer];
    }
    
}

-(void)setTimer{
    diffSeconds = 0;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.soundFile ofType:self.soundFileExtension];
    NSURL* url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID( (CFURLRef)objc_unretainedPointer(url), &alarmSound);
    
    counter = 0;
    if (self.setHour == 0 && self.setMinute == 0) {
        diffLabel.text = @"No Time Set!";
        [self.diffTimer invalidate];
        [self.repeatingTimer invalidate];
    }
    
    else{
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60.0f target:self selector:@selector(updateLabel:) userInfo:nil repeats:YES];
        self.repeatingTimer = timer;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateDiffLabel:) userInfo:nil repeats:YES];
        self.diffTimer = timer;
    }
    
}

-(void) checkAlarmExpiry:(id)sender {
    NSDate *now = [[NSDate alloc]init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(kCFCalendarUnitHour | kCFCalendarUnitMinute) fromDate:now];
    NSInteger currentHour = [components hour];
    NSInteger currentMinute = [components minute];
    if(self.setHour==currentHour && self.setMinute==currentMinute){
        AudioServicesPlaySystemSound(alarmSound);
        [self.alarmTriggerTimer invalidate];
        self.diffLabel.text = @"Time Up!";
    }
}

-(void) updateAlarmLabel:(id)sender {
    NSLog(@"%i %i %i",diffHour,diffMin, diffSeconds);
    if(diffHour==0&&diffMin==0&&diffSeconds==0){
        AudioServicesPlaySystemSound(alarmSound);
        [self.alarmTimer invalidate];
        self.diffLabel.text = @"Time Up!";
        return;
    }
    diffSeconds--;
    if(diffSeconds==-1){
        diffSeconds = 59;
        diffMin--;
    }
    if(diffMin==-1){
        if(diffHour>0){
            diffHour--;
        }
        /*else{
         diffLabel.text = @"Time Up!";
         AudioServicesPlaySystemSound(alarmSound);
         [self.alarmTimer invalidate];
         return;
         }*/
        diffMin = 59;
    }
    
    diffLabel.text = [[NSString alloc] initWithFormat:@"%02d:%02d:%02d Hours Left",diffHour,diffMin,diffSeconds];
}

-(void) updateLabel:(id)sender {
    self.setHour = [hourLabel.text integerValue];
    self.setMinute = [minLabel.text integerValue];
    if(self.setMinute==1){
        if(self.setHour==0){
            self.setMinute--;
        }
        else{
            //self.setHour--;
            self.setMinute--;
        }
    }
    else if (setMinute == 0){
        self.setMinute = 59;
    }
    else{
        self.setMinute--;
    }
    hourLabel.text = [[NSString alloc] initWithFormat:@"%02d",setHour];
    minLabel.text = [[NSString alloc] initWithFormat:@"%02d",setMinute];
    
    self.diffSeconds = 60;
}

-(void)updateDiffLabel:(id)sender {
    
    diffHour = self.setHour;
    diffMin = self.setMinute;
    
    if(!(diffHour==0 && diffMin==0 && diffSeconds==1)){
        counter = 0;
    }
    
    if (diffSeconds == 0 && setMinute >= 0) {
        diffSeconds = 59;
    }
    if (diffMin == 0 && diffHour >= 0) {
        if(diffHour==0){
            [self.diffTimer invalidate];
            diffLabel.text = @"Time Up!";
            AudioServicesPlaySystemSound(alarmSound);
            setMinute--;
            [self.repeatingTimer invalidate];
            return;
        }
        diffMin = 59;
        diffHour--;
        counter++;
    }
    if (counter == 0) {
        diffMin--;
        counter++;
    }
    
    NSString *diffLabelText = [[NSString alloc] initWithFormat:@"%02d:%02d:%02d Hours Left",diffHour,diffMin,diffSeconds];
    [diffLabel setNeedsDisplay];
    
    if (diffHour == 0 && diffMin == 0 && diffSeconds == 0) {
        [self.diffTimer invalidate];
        diffLabel.text = @"Time Up!";
        AudioServicesPlaySystemSound(alarmSound);
        setMinute--;
        [self.repeatingTimer invalidate];
        return;
    }
    
    diffSeconds--;
    diffLabel.text = diffLabelText;
    
}

@end
