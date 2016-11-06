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

@interface BNRItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView* headerView;

@end

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

- (UIView *)headerView {
  if (!_headerView) {
    [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                  owner:self
                                options:nil];
  }
  return _headerView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.tableView registerClass:[UITableViewCell class]
         forCellReuseIdentifier:@"UITableViewCell"];
  
  self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - Actions

- (IBAction)toggleEditingMode:(UIButton *)sender {
  if (self.editing) {
    [sender setTitle:@"Edit"
            forState:UIControlStateNormal];
    [self setEditing:NO
            animated:YES];
  } else {
    [sender setTitle:@"Done"
            forState:UIControlStateNormal];
    [self setEditing:YES
            animated:YES];
  }
}

- (IBAction)addNewItem:(UIButton *)sender {
  
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
