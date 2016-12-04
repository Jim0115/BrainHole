//
//  BNRImageStore.h
//  Homepwner
//
//  Created by 王仕杰 on 2016/12/4.
//  Copyright © 2016年 王仕杰. All rights reserved.
//

@import UIKit;

@interface BNRImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
