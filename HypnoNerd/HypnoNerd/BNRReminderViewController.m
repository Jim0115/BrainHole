//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by 王仕杰 on 26/10/2016.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import "BNRReminderViewController.h"

@import UserNotifications;

@interface BNRReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    self.tabBarItem.title = @"Reminder";
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (IBAction)addReminder:(UIButton *)sender {
  NSDate* date = self.datePicker.date;
}

@end
