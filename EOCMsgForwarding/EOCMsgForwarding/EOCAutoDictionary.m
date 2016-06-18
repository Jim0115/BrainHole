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
@property (nonatomic, copy) NSString* innerString;
@property (nonatomic, copy) NSArray* innerArray;

@end

id autoDictionaryGetter(id self, SEL _cmd) {
  EOCAutoDictionary* typedSelf = (EOCAutoDictionary *)self;
  NSMutableDictionary* backingStore = typedSelf.backingStore;
  
  NSString* key = NSStringFromSelector(_cmd);
  
//  NSMutableString* key = [NSStringFromSelector(_cmd) mutableCopy];
  
//  [key deleteCharactersInRange:NSMakeRange(0, 3)];
//  
//  NSString* lowerFirst = [[key substringToIndex:1] lowercaseString];
//  [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowerFirst];
  
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

- (instancetype)init {
  self = [super init];
  if (self) {
    _backingStore = [[NSMutableDictionary alloc] init];
  }
  
  return self;
}

//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//  NSString* selectorString = NSStringFromSelector(sel);
//  
//  if ([selectorString hasPrefix:@"set"]) {
//    class_addMethod(self,
//                    sel,
//                    (IMP)autoDictionarySetter,
//                    "v@:@");
//  } else {
//    class_addMethod(self,
//                    sel,
//                    (IMP)autoDictionaryGetter,
//                    "@@:");
//  }
//  return YES;
//}

- (NSArray *)innerArray {
  if (!_innerArray) {
    _innerArray = @[@1, @2, @3];
  }
  return _innerArray;
}

- (NSString *)innerString {
  if (!_innerString) {
    _innerString = @"some string";
  }
  return _innerString;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
  if ([self.innerString respondsToSelector:aSelector]) {
    return self.innerString;
  } else if ([self.innerArray respondsToSelector:aSelector]) {
    return self.innerArray;
  }
  return [super forwardingTargetForSelector:aSelector];
}

- (id)valueForKey:(NSString *)key {
  return _backingStore[key];
}

- (void)setValue:(id)value forKey:(NSString *)key {
  _backingStore[key] = value;
}

@end


