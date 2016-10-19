//
//  HypnosisterView.m
//  Hypnosister
//
//  Created by 王仕杰 on 16/10/2016.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import "HypnosisterView.h"

@implementation HypnosisterView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  
    CGFloat maxRadius = hypotf(self.bounds.size.width, self.bounds.size.height) / 2;
  
  
  CGContextRef contextRef = UIGraphicsGetCurrentContext();
  
  CGFloat components[] = {1, 0, 0, 1};
  CGColorRef color = CGColorCreate(CGColorSpaceCreateDeviceRGB(), components);
  CGContextSetStrokeColorWithColor(contextRef, color);
  
//  CGContextMoveToPoint(contextRef, 100, 100);
//  CGContextAddLineToPoint(contextRef, 200, 200);
  
  CGMutablePathRef path = CGPathCreateMutable();
  
  
  for (CGFloat currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
    CGPathMoveToPoint(path, NULL, self.center.x + currentRadius, self.center.y);
    CGPathAddArc(path, NULL, self.center.x, self.center.y, currentRadius, 0, M_PI * 2, false);
  }
  
  CGContextAddPath(contextRef, path);
  
  CGContextSetLineWidth(contextRef, 5);
  
  CGContextStrokePath(contextRef);
  
  CGPathRelease(path);
  
  //  UIBezierPath* path = [UIBezierPath new];
  //
  //  for (CGFloat currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
  //    [path moveToPoint:CGPointMake(self.center.x + currentRadius, self.center.y)];
  //
  //    [path addArcWithCenter:self.center
  //                    radius:currentRadius
  //                startAngle:0
  //                  endAngle:M_PI * 2
  //                 clockwise:YES];
  //  }
  //
  //  path.lineWidth = 10;
  //
  //  [[UIColor lightGrayColor] setStroke];
  //
  //  [path stroke];
}


@end
