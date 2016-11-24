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

#import "BNRDetailViewController.h"

@interface BNRItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView* headerView;

@end

@implementation BNRItemsViewController

- (instancetype)init {
  self = [self initWithStyle:UITableViewStylePlain];
  self.title = @"Homepwner";
  
  return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  if (self = [super initWithStyle:UITableViewStylePlain]) {
//    for (int i = 0; i < 5; i++) {
//      [[BNRItemStore sharedStore] createItem];
//    }
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

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self.tableView reloadData];
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
//  NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
  
  BNRItem* newItem = [[BNRItemStore sharedStore] createItem];
  NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
  
  NSIndexPath* indexPath = [NSIndexPath indexPathForRow:lastRow
                                              inSection:0];
  
  [self.tableView insertRowsAtIndexPaths:@[indexPath]
                        withRowAnimation:UITableViewRowAnimationMiddle];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    BNRItem* itemToRemove = [[BNRItemStore sharedStore] allItems][indexPath.row];
    [[BNRItemStore sharedStore] removeItem:itemToRemove];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
  }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row
                                      toIndex:destinationIndexPath.row];
}

#pragma mark - tableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
  return @"Remove";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  BNRDetailViewController* detailViewController = [BNRDetailViewController new];
  
  detailViewController.item = [[BNRItemStore sharedStore] allItems][indexPath.row];
  
  [self showViewController:detailViewController sender:self];
}

@end
