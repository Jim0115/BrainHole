//
//  LikeButton.m
//  Hypnosister
//
//  Created by 王仕杰 on 20/10/2016.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import "LikeButton.h"

@implementation LikeButton

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor whiteColor];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef contextRef = UIGraphicsGetCurrentContext();
  
  CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
  CGFloat components[] = {0, 1, 0, 1, 0, 0, 1, 1};
  CGFloat locations[] = {0, 1};
  CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpaceRef, components, locations, 2);
  CGColorSpaceRelease(colorSpaceRef);
  CGContextDrawLinearGradient(contextRef, gradient, CGPointMake(0, 0), CGPointMake(rect.size.width, rect.size.height), 0);
  
  CGContextAddArc(contextRef, rect.size.width / 2, rect.size.height / 2, rect.size.width / 3, 0, M_PI * 2, false);
  
  CGContextSetStrokeColorWithColor(contextRef, [[UIColor redColor] CGColor]);
//  CGContextSetFillColorWithColor(contextRef, [[UIColor blueColor] CGColor]);
  
  
//  CGContextSetShadow(contextRef, CGSizeMake(10, 10), 8);
  
  CGContextDrawPath(contextRef, kCGPathFillStroke);
}


@end
