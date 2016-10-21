//
//  LikeButton.h
//  Hypnosister
//
//  Created by 王仕杰 on 20/10/2016.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LBState) {
  LBStateUnselected,
  LBStateSelected
};

@interface LikeButton : UIControl

@property (nonatomic, assign) LBState selectedState;

@end
