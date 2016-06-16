//
//  EOCAutoDictionary.m
//  HelloWorldInOC
//
//  Created by 王仕杰 on 6/15/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import "EOCAutoDictionary.h"
#import <objc/runtime.h>

@interface EOCAutoDictionary ()

@property (nonatomic) NSMutableDictionary* backingStore;
@property (nonatomic, copy) NSString* str;

@end

id autoDictionaryGetter(id self, SEL _cmd) {
  EOCAutoDictionary* typedSelf = (EOCAutoDictionary *)self;
  NSMutableDictionary* backingStore = typedSelf.backingStore;
  
  NSString* key = NSStringFromSelector(_cmd);
  
  return backingStore[key];
}

void autoDictionarySetter(id self, SEL _cmd, id value) {
  EOCAutoDictionary* typedSelf = (EOCAutoDictionary *)self;
  NSMutableDictionary* backingStore = typedSelf.backingStore;
  
  // "setOpaqueObject:" remove "set", ":", lowercase the first letter of the rest
  
  NSString* selectorString = NSStringFromSelector(_cmd);
  NSMutableString* key = [selectorString mutableCopy];
  
  // remove ":"
  [key deleteCharactersInRange:NSMakeRange(key.length - 1, 1)];
  
  // remove "set" prefix
  [key deleteCharactersInRange:NSMakeRange(0, 3)];
  
  // lowercase the first letter
  NSString* lowerFirst = [[key substringToIndex:1] lowercaseString];
  [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowerFirst];
  
  if (value) {
    backingStore[key] = value;
  } else {
    [backingStore removeObjectForKey:key];
  }
}

@implementation EOCAutoDictionary

@dynamic string, number, date, opaqueObject;

- (NSString *)str {
  if (!_str) {
    _str = [[NSString alloc] init];
  }
  return _str;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _backingStore = [[NSMutableDictionary alloc] init];
  }
  return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
  NSString* selectorString = NSStringFromSelector(sel);
  
  if ([selectorString hasPrefix:@"set"]) {
    class_addMethod(self,
                    sel,
                    (IMP)autoDictionarySetter,
                    "v@:@");
  } else {
    class_addMethod(self,
                    sel,
                    (IMP)autoDictionaryGetter,
                    "@@:");
  }
  return YES;
}

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//  if ([NSStringFromSelector(aSelector) isEqualToString:NSStringFromSelector(@selector(uppercaseString))]) {
//    return self.str;
//  }
//  return nil;
}

@end


