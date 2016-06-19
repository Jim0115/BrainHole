//
//  AppDelegate.m
//  ChangeButtonTarget
//
//  Created by 王仕杰 on 6/18/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import <objc/runtime.h>

#import "AppDelegate.h"
#import "ViewController.h"

#import "UIButton+ClickedCount.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  
  _window.rootViewController = [[ViewController alloc] init];
  
  Method addTarget = class_getInstanceMethod([UIButton class], @selector(addTarget:action:forControlEvents:));
  Method addTargetWithCount = class_getInstanceMethod([UIButton class], @selector(addTargetWithCount:action:forControlEvents:));
  
  method_exchangeImplementations(addTarget, addTargetWithCount);
  
  [_window makeKeyAndVisible];
  return YES;
}


@end
