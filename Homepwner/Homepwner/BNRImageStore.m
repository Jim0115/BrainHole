//
//  BNRImageStore.m
//  Homepwner
//
//  Created by 王仕杰 on 2016/12/4.
//  Copyright © 2016年 王仕杰. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property (nonatomic, strong) NSMutableDictionary* dictionary;

@end

@implementation BNRImageStore

+ (instancetype)sharedStore {
  static BNRImageStore* sharedStore = nil;
  
  if (!sharedStore) {
    sharedStore = [[self alloc] initPrivate];
  }
  return sharedStore;
}

- (instancetype)init {
  @throw [NSException exceptionWithName:@"Singleton"
                                 reason:@"Use +[BNRImageStore sharedStore]"
                               userInfo:nil];
  return nil;
}

- (instancetype)initPrivate {
  if (self = [super init]) {
    _dictionary = [NSMutableDictionary dictionary];
  }
  return self;
}

@end
