//
//  BNRItem.m
//  Homepwner
//
//  Created by 王仕杰 on 2016/10/30.
//  Copyright © 2016年 王仕杰. All rights reserved.
//

#import "BNRItem.h"

@interface BNRItem ()

@property (nonatomic, strong, readwrite) NSDate* dateCreated;

@end

@implementation BNRItem

- (instancetype)init {
  return [self initWithItemName:@"Item"];
}

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(NSInteger)value serialNumber:(NSString *)sNumber {
  if (self = [super init]) {
    _name = name;
    _serialNumber = sNumber;
    _valueInDollars = value;
    
    _dateCreated = [NSDate date];
  }
  return self;
}

- (instancetype)initWithItemName:(NSString *)name {
  return [self initWithItemName:name
                 valueInDollars:0
                   serialNumber:@""];
}

+ (instancetype)randomItem {
  NSArray* randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
  NSArray* randomNounList = @[@"Bear", @"Spork", @"Mac"];
  
  NSInteger adjectiveIndex = arc4random_uniform((UInt32)randomAdjectiveList.count);
  NSInteger nounIndex = arc4random_uniform((UInt32)randomNounList.count);
  
  NSString* randomName = [NSString stringWithFormat:@"%@ %@", randomAdjectiveList[adjectiveIndex], randomNounList[nounIndex]];
  NSInteger randomValue = arc4random_uniform(101);
  NSString* randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c", '0' + arc4random_uniform(10), 'A' + arc4random_uniform(26), '0' + arc4random_uniform(10), 'A' + arc4random_uniform(26), '0' + arc4random_uniform(10)];
  
  return [[self alloc] initWithItemName:randomName
                         valueInDollars:randomValue
                           serialNumber:randomSerialNumber];
  
}

- (NSString *)description {
  return [NSString stringWithFormat:@"%@ (%@): Worth $%ld, recorded on %@", _name, _serialNumber, _valueInDollars, _dateCreated];
}

@end
