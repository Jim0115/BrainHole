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
    
    dict.string = @"amazing";
    NSLog(@"%@", dict.string);
//    [dict setValue:@"haha" forKey:@"string"];
//    NSLog(@"%@", [dict valueForKey:@"string"]);
  }
  return 0;
}
