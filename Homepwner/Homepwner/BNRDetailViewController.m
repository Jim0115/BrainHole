//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by 王仕杰 on 2016/11/18.
//  Copyright © 2016年 王仕杰. All rights reserved.
//

#import "BNRDetailViewController.h"

#import "BNRItem.h"

@interface BNRDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation BNRDetailViewController

- (void)setItem:(BNRItem *)item {
  _item = item;
  self.title = item.name;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  _nameField.text = _item.name;
  _serialNumberField.text = _item.serialNumber;
  _valueField.text = [NSString stringWithFormat:@"%ld", _item.valueInDollars];
  
  NSDateFormatter* formatter = [NSDateFormatter new];
  formatter.dateStyle = NSDateFormatterMediumStyle;
  formatter.timeStyle = NSDateFormatterNoStyle;
  
  _dateLabel.text = [formatter stringFromDate:_item.dateCreated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  
  [self.view endEditing:YES];
  
  _item.name = _nameField.text;
  _item.serialNumber = _serialNumberField.text;
  _item.valueInDollars = [_valueField.text integerValue];
}

@end
