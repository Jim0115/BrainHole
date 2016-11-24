//
//  AppDelegate.m
//  Homepwner
//
//  Created by 王仕杰 on 2016/10/30.
//  Copyright © 2016年 王仕杰. All rights reserved.
//

#import "AppDelegate.h"

#import "BNRItemsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  
  _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[BNRItemsViewController alloc] init]];
  
  [_window makeKeyAndVisible];
  return YES;
}


@end
