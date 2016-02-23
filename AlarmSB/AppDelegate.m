//
//  AppDelegate.m
//  AlarmSB
//
//  Created by Vivek Srinivasan on 20/03/13.
//  Copyright (c) 2013 Vivek Srinivasan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "InitViewController.h"

@implementation AppDelegate

@synthesize backgroundTimer;
@synthesize counter;

UIBackgroundTaskIdentifier bgTask;
ViewController *vc;
UILocalNotification *localNotif;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // Handle launching from a notification
    application.applicationIconBadgeNumber = 0;
    UILocalNotification *localNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
        NSLog(@"Recieved Notification %@",localNotif);
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //As we are going into the background, I want to start a background task to clean up the disk caches
    counter = 0;
    backgroundTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    //vc = [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];
    vc = (ViewController *)((InitViewController *)self.window.rootViewController).topViewController;
    
    // Notification will fire in one minute
    //NSDate *notifDate = [calendar dateFromComponents:dateComps];
    
    [application cancelAllLocalNotifications];
    localNotif = [[UILocalNotification alloc] init];
    //localNotif.fireDate =
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    localNotif.alertBody = @"Wake up!";
    localNotif.alertAction = NSLocalizedString(@"View Details", nil);
    localNotif.applicationIconBadgeNumber = 1;
    
    if([vc.alarmMode isEqualToString:@"Timer"])
    {
        int seconds = vc.diffHour*3600 + vc.diffMin*60 + vc.diffSeconds;
        NSDate *alertTime = [[NSDate date]
                             dateByAddingTimeInterval:seconds];
        localNotif.fireDate = alertTime;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    }
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) { //Check if our iOS version supports multitasking I.E iOS 4
        if ([[UIDevice currentDevice] isMultitaskingSupported]) { //Check if device supports mulitasking
            UIApplication *application = [UIApplication sharedApplication]; //Get the shared application instance

            __block UIBackgroundTaskIdentifier background_task; //Create a task object
            
            background_task = [application beginBackgroundTaskWithExpirationHandler: ^{
                [application endBackgroundTask:background_task]; //Tell the system that we are done with the tasks
                background_task = UIBackgroundTaskInvalid; //Set the task to be invalid
                //System will be shutting down the app at any point in time now
            }];
            
            //Background tasks require you to use asyncrous tasks
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                
                //[application endBackgroundTask: background_task]; //End the task so the system knows that you are done with what you need to perform
                //background_task = UIBackgroundTaskInvalid; //Invalidate the background_task
            });
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    AudioServicesDisposeSystemSoundID(vc.alarmSound);
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) updateTime:(id)sender {
    counter++;
    if([vc.alarmMode isEqual:@"Alarm"]){
        NSDate *now = [[NSDate alloc]init];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond) fromDate:now];
        NSInteger currentHour = [components hour];
        NSInteger currentMinute = [components minute];
        NSInteger currentSecond = [components second];
        if(currentHour == vc.setHour && currentMinute == vc.setMinute && currentSecond==1){
                [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif];
        }
    }
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    // Handle the notificaton when the app is running
    NSLog(@"Recieved Notification %@",notif);
}

@end
