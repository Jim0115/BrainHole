//
//  UIButton+ClickedCount.h
//  MethodSwizzling
//
//  Created by 王仕杰 on 6/18/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ClickedCount)

- (void)addTargetWithCount:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
