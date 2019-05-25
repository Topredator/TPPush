//
//  TPAppDelegate.m
//  TPPush
//
//  Created by Topredator on 02/26/2019.
//  Copyright (c) 2019 Topredator. All rights reserved.
//

#import "TPAppDelegate.h"

#define kGTDevAppId @"gLCYwQiwJy53Eh2or5DOX4"
#define kGTDevAppKey @"cfUBRwz1Eo6rNUadkhlQ28"
#define kGTDevAppSecret  @"bt4jtbb8rw6uhUtjAZrXz8"

@implementation TPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    [TPPushInterface registerNotificationWithModel:TPGTPushModel(@"cnC6ZmPMqX79vi1G6IW2l4", @"SZI9E8jobP6jVJisD0pot6", @"0MjAxe1HeG73KzcShPPvnA")];
    [TPPushInterface registerNotificationWithModel:TPGTPushModel(kGTDevAppId, kGTDevAppKey, kGTDevAppSecret)];
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
