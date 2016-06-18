//
//  main.m
//  EOCMsgForwarding
//
//  Created by 王仕杰 on 6/15/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EOCAutoDictionary.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    EOCAutoDictionary* dict = [[EOCAutoDictionary alloc] init];
    
//    NSLog(@"%d", [dict respondsToSelector:@selector(stringFromDate:)]);
    NSLog(@"%@", [(NSString *)dict uppercaseString]);
    NSLog(@"%@", [(NSArray *)dict firstObject]);
  }
  return 0;
}
