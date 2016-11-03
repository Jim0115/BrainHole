//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by 王仕杰 on 2016/10/30.
//  Copyright © 2016年 王仕杰. All rights reserved.
//

#import "BNRItemsViewController.h"

#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation BNRItemsViewController

- (instancetype)init {
  self = [self initWithStyle:UITableViewStylePlain];
  return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  if (self = [super initWithStyle:UITableViewStylePlain]) {
    for (int i = 0; i < 5; i++) {
      [[BNRItemStore sharedStore] createItem];
    }
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.tableView registerClass:[UITableViewCell class]
        forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [BNRItemStore sharedStore].allItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//  UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                                 reuseIdentifier:@"UITableViewCell"];
  UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                               forIndexPath:indexPath];
  
  NSArray* items = [BNRItemStore sharedStore].allItems;
  BNRItem* item = items[indexPath.row];
  
  cell.textLabel.text = item.description;
  
  return cell;
}

@end
