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
  
  CGContextAddArc(contextRef, rect.size.width / 2, rect.size.height / 2, rect.size.width / 3, 0, M_PI * 2, false);
  
  CGContextSetStrokeColorWithColor(contextRef, [[UIColor redColor] CGColor]);
  CGContextSetFillColorWithColor(contextRef, [[UIColor blueColor] CGColor]);
  
  CGContextSaveGState(contextRef);
  
  CGContextSetShadow(contextRef, CGSizeMake(10, 10), 8);
  
  CGContextRestoreGState(contextRef);
  
  CGContextDrawPath(contextRef, kCGPathFillStroke);
}


@end
