//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by 王仕杰 on 26/10/2016.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisterView.h"

@interface BNRHypnosisViewController ()

@end

@implementation BNRHypnosisViewController

- (instancetype)init {
  if (self = [super init]) {
    self.tabBarItem.title = @"Hypnotize";
  }
  return self;
}

- (void)loadView {
  self.view = [[BNRHypnosisterView alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIInterpolatingMotionEffect* motionEffect;
  
  for (int i = 0; i < 2; i++) {
    motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:(i ? @"center.x" : @"center.y")
                                                    type:(i ? UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis : UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis)];
    motionEffect.maximumRelativeValue = @25;
    motionEffect.minimumRelativeValue = @-25;
    [self.view addMotionEffect:motionEffect];
  }
}

@end
