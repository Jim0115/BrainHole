//
//  UIButton+ClickedCount.m
//  MethodSwizzling
//
//  Created by 王仕杰 on 6/18/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import "UIButton+ClickedCount.h"
#import <objc/runtime.h>
#import <objc/message.h>


@implementation UIButton (ClickedCount)

static char* countKey;
static char* blockKey;

- (NSUInteger)count {
  NSNumber* count = objc_getAssociatedObject(self, countKey);
  return count.unsignedIntegerValue;
}

- (void)setCount:(NSUInteger)count {
  objc_setAssociatedObject(self, countKey, @(count), OBJC_ASSOCIATION_ASSIGN);
}

- (void (^)())actionBlock {
  return objc_getAssociatedObject(self, blockKey);
}

- (void)setActionBlock:(void (^)())block {
  objc_setAssociatedObject(self, blockKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addTargetWithCount:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
  __weak typeof(target) weakTarget = target;
  
  self.actionBlock = ^{
     ((void (*)(void *, SEL, UIView *))objc_msgSend)((__bridge void *)(weakTarget), action , nil);
  };
  
  [self addTargetWithCount:self action:@selector(foo:) forControlEvents:controlEvents];
}

- (void)foo:(UIButton *)sender {
  self.count++;
  NSLog(@"%lu", self.count);
  
  sender.actionBlock();
}


@end
