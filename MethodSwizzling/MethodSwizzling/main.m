//
//  main.m
//  MethodSwizzling
//
//  Created by 王仕杰 on 6/18/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#import "NSString+lowercaseStringWithNotification.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    Method lower = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method lowerNoti = class_getInstanceMethod([NSString class], @selector(lowercaseStringWithNotification));
    
    method_exchangeImplementations(lower, lowerNoti);
    
    NSString* str = @"Aloha";
    
    NSLog(@"%@", [str lowercaseString]);
  }
  return 0;
}
