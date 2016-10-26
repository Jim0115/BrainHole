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
}

@end
