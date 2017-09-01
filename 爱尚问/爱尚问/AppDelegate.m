//
//  AppDelegate.m
//  爱尚问
//
//  Created by Mac on 17/8/31.
//  Copyright © 2017年 杜浩. All rights reserved.
//

#import "AppDelegate.h"
#import "CheckVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CheckVC * vc = [CheckVC new];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    
    
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}
- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
