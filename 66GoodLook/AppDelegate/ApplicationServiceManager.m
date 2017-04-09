//
//  ApplicationServiceManager.m
//  66GoodLook
//
//  Created by Yanci on 17/4/9.
//  Copyright © 2017年 Yanci. All rights reserved.
//


#import "ApplicationServiceManager.h"
#import "ApplicationServiceBase.h"


@interface ApplicationServiceManager ()
@property (nonatomic,strong) NSArray *services;
@end

@implementation ApplicationServiceManager


- (id)init {
    if (self = [super init]) {
        self.services = [self fillServices];
    }
    return self;
}

- (NSArray <ApplicationService>*)fillServices {
    return nil;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    for (id <ApplicationService> service in [self services]) {
        if ([service respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
            return [service application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    for (id <ApplicationService> service in [self services]) {
        if ([service respondsToSelector:@selector(applicationWillResignActive:)])
            [service applicationWillResignActive:application];
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    for (id <ApplicationService> service in [self services]) {
        if ([service respondsToSelector:@selector(applicationDidEnterBackground:)])
            [service applicationDidEnterBackground:application];
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    for (id <ApplicationService> service in [self services]) {
        if ([service respondsToSelector:@selector(applicationWillEnterForeground:)])
            [service applicationWillEnterForeground:application];
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    for (id <ApplicationService> service in [self services]) {
        if ([service respondsToSelector:@selector(applicationDidBecomeActive:)])
            [service applicationDidBecomeActive:application];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    for (id <ApplicationService> service in [self services]) {
        if ([service respondsToSelector:@selector(applicationWillTerminate:)])
            [service applicationWillTerminate:application];
    }
    
}

@end
