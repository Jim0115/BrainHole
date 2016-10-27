//
//  AppDelegate.m
//  HypnoNerd
//
//  Created by 王仕杰 on 26/10/2016.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import "AppDelegate.h"

#import "BNRHypnosisViewController.h"
#import "BNRReminderViewController.h"

@import UserNotifications;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  
  UITabBarController* tabBarController = [[UITabBarController alloc] init];
  [tabBarController addChildViewController:[[BNRHypnosisViewController alloc] init]];
  [tabBarController addChildViewController:[[BNRReminderViewController alloc] initWithNibName:@"BNRReminderViewController"
                                                                                       bundle:[NSBundle mainBundle]]];
  
  _window.rootViewController = tabBarController;
  [_window makeKeyAndVisible];
  
  UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
  [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound)
                        completionHandler:^(BOOL granted, NSError * _Nullable error) {
                          
                        }];
  
  return YES;
}




@end
