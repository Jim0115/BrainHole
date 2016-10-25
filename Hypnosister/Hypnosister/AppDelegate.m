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
  
  UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:rootView.bounds];
  [rootView addSubview:scrollView];
  
//  CGRect bigRect = rootView.bounds;
//  bigRect.size.width *= 2;
//  bigRect.size.height *= 2;
  
  CGRect hypnoRect = rootView.bounds;
  HypnosisterView* hypnosisterView = [[HypnosisterView alloc] initWithFrame:hypnoRect];
  [scrollView addSubview:hypnosisterView];
  
  hypnoRect.origin.x += hypnoRect.size.width;
  HypnosisterView* hypnosisterView2 = [[HypnosisterView alloc] initWithFrame:hypnoRect];
//  hypnosisterView2.frame = hypnoRect;
  [scrollView addSubview:hypnosisterView2];
  
  hypnoRect.size.width *= 2.5;
  scrollView.contentSize = hypnoRect.size;
  scrollView.bounces = NO;
  scrollView.pagingEnabled = YES;
  
  [_window makeKeyAndVisible];
  return YES;
}


@end
