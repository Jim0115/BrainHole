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

@property (nonatomic, assign) BOOL login;

@end

@implementation ViewController

- (void)setLogin:(BOOL)login {
  _login = login;
  
  [self switchLoginButtonEnable:NO];
  
  for (UIView* view in self.view.subviews) {
    if (view.tag == 1001 || view.tag == 2001) {
      view.hidden = _login;
    }
    
    switch (view.tag) {
      case 1001:
        ((UITextField *)view).text = nil;
        if (!_login) { [view becomeFirstResponder]; }
        break;
      case 1002:
        ((UITextField *)view).placeholder = _login ? @"用户名" : @"密码";
        ((UITextField *)view).text = nil;
        if (_login) { [view becomeFirstResponder]; }
        break;
      case 1003:
        ((UITextField *)view).placeholder = _login ? @"密码" : @"重复密码";
        ((UITextField *)view).text = nil;
      default:
        break;
    }
  }
  
  [self.loginButton setTitle:_login ? @"登录" : @"注册" forState:UIControlStateNormal];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(spaceDidTap)]];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  _login = YES;
  
  self.loginButton.backgroundColor = [UIColor colorWithRed:0.56
                                                     green:0.75
                                                      blue:0.98
                                                     alpha:1];
  
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardStatusWillChange:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardStatusWillChange:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardWillShowNotification
                                                object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardStatusWillChange:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

#pragma mark - deal with keyboard

- (void)spaceDidTap {
  
  for (NSNumber* i in @[@1001, @1002, @1003]) {
    [[self.view viewWithTag:i.integerValue] resignFirstResponder];
  }
}

- (void)keyboardStatusWillChange:(NSNotification *)noti {
  
  BOOL difference = [noti.name isEqualToString:UIKeyboardWillShowNotification];
  
  self.buttonCenterYConstraint.constant = difference ? -120 : 0;
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
      [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == 1003) { [obj becomeFirstResponder];  *stop = YES; }
      }];
      break;
    case 1003:
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
    if (subview.tag == 1002 || subview.tag == 1003) {
      UITextField* textField = (UITextField *)subview;
      if ([textField.text isEqualToString:@""]) {
        enable = NO;
        break;
      }
    }
  }
  [self switchLoginButtonEnable:enable];
}

- (void)switchLoginButtonEnable:(BOOL)enable {
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

- (IBAction)switchLoginStatus:(UIButton *)sender {
  self.login = !self.login;
  if (self.login) {
    [sender setTitle:@"没有账号？点此注册" forState:UIControlStateNormal];
  } else {
    [sender setTitle:@"已有账号？点此登录" forState:UIControlStateNormal];
  }
}


- (void)dealloc {
  NSLog(@"dealloc");
}
@end
