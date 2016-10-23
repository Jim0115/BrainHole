//
//  AppDelegate.m
//  Hypnosister
//
//  Created by 王仕杰 on 16/10/2016.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import "AppDelegate.h"
#import "HypnosisterView.h"
#import "LikeButton.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  
  _window.rootViewController = [UIViewController new];
  UIView* rootView = _window.rootViewController.view;
  rootView.backgroundColor = [UIColor whiteColor];
  
//  [rootView addSubview:[[LikeButton alloc] initWithFrame:CGRectMake(50, 50, 200, 200)]];
  
  HypnosisterView* firstView = [[HypnosisterView alloc] initWithFrame:rootView.bounds];
  [rootView addSubview:firstView];
  
  [_window makeKeyAndVisible];
  return YES;
}


@end
