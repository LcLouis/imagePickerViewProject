//
//  AppDelegate.m
//  imagePickerViewProject
//
//  Created by Lc、 on 16/3/19.
//  Copyright © 2016年 Lc、. All rights reserved.
//

#import "AppDelegate.h"
//#import "CacheCleanerPlugin.h"
//#import "RetainCycleLoggerPlugin.h"
#import "ViewController.h"
#import "FBStandardGraphEdgeFilters.h"
#import <FBMemoryProfiler/FBMemoryProfiler.h>

@interface AppDelegate (){
    FBMemoryProfiler *_memoryProfiler;
}


//@property (strong, nonatomic) UIWindow *window;



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Override point for customization after application launch.
    NSArray *filters = @[FBFilterBlockWithObjectIvarRelation([UIView class], @"_subviewCache"),
                         FBFilterBlockWithObjectIvarRelation([UIPanGestureRecognizer class], @"_internalActiveTouches")];
    FBObjectGraphConfiguration *configuration =
    [[FBObjectGraphConfiguration alloc] initWithFilterBlocks:filters
                                         shouldInspectTimers:YES];
    _memoryProfiler = [[FBMemoryProfiler alloc] initWithPlugins:@[[ViewController new]]
                               retainCycleDetectorConfiguration:configuration];
    [_memoryProfiler enable];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier
  completionHandler:(void (^)())completionHandler {
    self.backgroundSessionCompletionHandler = completionHandler;
    //add notification
    [self presentNotification];
}

-(void)presentNotification{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody = @"Download Complete!";
    localNotification.alertAction = @"Background Transfer Download!";
    //On sound
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    //increase the badge number of application plus 1
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
}

@end
