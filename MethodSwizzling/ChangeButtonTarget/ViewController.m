//
//  ViewController.m
//  ChangeButtonTarget
//
//  Created by 王仕杰 on 6/18/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) UIButton* button;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  _button = [UIButton buttonWithType:UIButtonTypeSystem];
  [_button setTitle:@"Button"
           forState:UIControlStateNormal];
  [_button addTarget:self
              action:@selector(tapped:)
    forControlEvents:UIControlEventTouchUpInside];
  
  _button.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_button];
  
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                       attribute:NSLayoutAttributeCenterX
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:_button
                                                       attribute:NSLayoutAttributeCenterX
                                                      multiplier:1
                                                        constant:0]];
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:_button
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1
                                                         constant:0]];
}

- (void)tapped:(UIButton *)sender {
  NSLog(@"tapped!");
}

@end
