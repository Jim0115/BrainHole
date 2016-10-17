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
//  CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) / 2;
  CGFloat maxRadius = hypotf(self.bounds.size.width, self.bounds.size.height) / 2;
  
  CGContextRef currentContext = UIGraphicsGetCurrentContext();
  
  CGContextSetRGBStrokeColor(currentContext, 1, 1, 1, 1);
  
  CGMutablePathRef path = CGPathCreateMutable();
  
  for (CGFloat currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
    CGPathMoveToPoint(path, NULL, self.center.x + currentRadius, self.center.y);
    CGPathAddArc(path, NULL, self.center.x, self.center.y, currentRadius, 0, M_PI * 2, true);
  }
  
  CGContextAddPath(currentContext, path);
  CGContextStrokePath(currentContext);
  CGPathRelease(path);
  
  CGContextSetStrokeColorWithColor(currentContext, [[UIColor redColor] CGColor]);
  
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
