//
//  BNRItemStore.m
//  Homepwner
//
//  Created by 王仕杰 on 2016/10/30.
//  Copyright © 2016年 王仕杰. All rights reserved.
//

#import "BNRItemStore.h"

#import "BNRItem.h"

@interface BNRItemStore ()

@property (nonatomic, strong) NSMutableArray<BNRItem *>* privateItems;

@end

@implementation BNRItemStore

+ (instancetype)sharedStore {
  static BNRItemStore* sharedStore = nil;
  
  if (!sharedStore) {
    sharedStore = [[self alloc] init];
  }
  
  return sharedStore;
}

- (instancetype)init {
  if (self = [super init]) {
    _privateItems = [NSMutableArray array];
  }
  return self;
}

- (NSArray<BNRItem *> *)allItems {
  return _privateItems;
}

- (BNRItem *)createItem {
  BNRItem* item = [BNRItem randomItem];
  
  [_privateItems addObject:item];
  
  return item;
}

- (void)removeItem:(BNRItem *)item {
  [_privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
  if (fromIndex == toIndex) { return; }
  
  BNRItem* item = _privateItems[fromIndex];
  [_privateItems removeObjectAtIndex:fromIndex];
  [_privateItems insertObject:item atIndex:toIndex];
}

@end
