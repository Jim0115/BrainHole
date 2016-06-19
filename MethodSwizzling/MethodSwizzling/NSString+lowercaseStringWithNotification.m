//
//  NSString+lowercaseStringWithNotification.m
//  MethodSwizzling
//
//  Created by 王仕杰 on 6/18/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import "NSString+lowercaseStringWithNotification.h"

@implementation NSString (lowercaseStringWithNotification)

- (NSString *)lowercaseStringWithNotification {
  NSString* lower = [self lowercaseStringWithNotification];
  NSLog(@"%@ -> %@", self, lower);
  return lower;
}

@end
