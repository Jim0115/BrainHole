//
//  ViewController.m
//  LoginDemo
//
//  Created by 王仕杰 on 7/11/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonCenterYConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoViewTopConstraint;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  self.loginButton.backgroundColor = [UIColor colorWithRed:0.56
                                                     green:0.75
                                                      blue:0.98
                                                     alpha:1];

  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardStatusWillChange:)
                                               name:UIKeyboardWillChangeFrameNotification
                                             object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardWillChangeFrameNotification
                                                object:nil];
}

- (void)keyboardStatusWillChange:(NSNotification *)noti {
  CGRect beginFrame = ((NSNumber *)noti.userInfo[UIKeyboardFrameBeginUserInfoKey]).CGRectValue;
  CGRect endFrame = ((NSNumber *)noti.userInfo[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
  
  CGFloat difference = endFrame.origin.y - beginFrame.origin.y;
  if (!difference) { return; }
  
  self.buttonCenterYConstraint.constant = difference < 0 ? -120 : 0;
  self.logoViewTopConstraint.constant = self.buttonCenterYConstraint.constant;

  [UIView animateWithDuration:0.25
                   animations:^{
                     [self.view layoutIfNeeded];
                     self.registerButton.alpha = self.buttonCenterYConstraint.constant == 0 ? 1 : 0;
                   }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  switch (textField.tag) {
    case 1001:
      [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == 1002) { [obj becomeFirstResponder];  *stop = YES; }
      }];
      break;
    case 1002:
      NSLog(@"登录");
      break;
    default:
      @throw [NSException exceptionWithName:@"Tag Not Found"
                                     reason:nil
                                   userInfo:nil];
      break;
  }
  return NO;
}

- (IBAction)textFieldValueChanged:(UITextField *)sender {
  BOOL enable = YES;
  
  // 只有当两个 textField 同时不为空时 登录按钮可用
  for (UIView* subview in self.view.subviews) {
    if (subview.tag == 1001 || subview.tag == 1002) {
      UITextField* textField = (UITextField *)subview;
      if ([textField.text isEqualToString:@""]) {
        enable = NO;
        break;
      }
    }
  }
  
  if (enable) {
    self.loginButton.backgroundColor = [UIColor colorWithRed:0.22
                                                       green:0.51
                                                        blue:0.96
                                                       alpha:1];
  } else {
    self.loginButton.backgroundColor = [UIColor colorWithRed:0.56
                                                       green:0.75
                                                        blue:0.98
                                                       alpha:1];
  }
  self.loginButton.enabled = enable;
}

@end
