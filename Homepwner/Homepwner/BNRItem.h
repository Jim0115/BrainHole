//
//  BNRItem.h
//  Homepwner
//
//  Created by 王仕杰 on 2016/10/30.
//  Copyright © 2016年 王仕杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSInteger valueInDollars;
@property (nonatomic, copy) NSString* serialNumber;

@property (nonatomic, strong, readonly) NSDate* dateCreated;

@property (nonatomic, copy) NSString* itemKey;


- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(NSInteger)value
                    serialNumber:(NSString *)sNumber NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithItemName:(NSString *)name;

+ (instancetype)randomItem;

@end
