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
    self.circleColor = [UIColor lightGrayColor];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  
  CGFloat maxRadius = hypotf(self.bounds.size.width, self.bounds.size.height) / 2;
  
  UIBezierPath* path = [UIBezierPath new];
  
  for (CGFloat currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
    [path moveToPoint:CGPointMake(self.bounds.size.width / 2 + currentRadius, self.bounds.size.height / 2)];
    
    [path addArcWithCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
                    radius:currentRadius
                startAngle:0
                  endAngle:M_PI * 2
                 clockwise:YES];
  }
  
  path.lineWidth = 10;
  
  [_circleColor setStroke];
  
  [path stroke];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  
  CGFloat red = arc4random_uniform(101) / 100.0;
  CGFloat blue = arc4random_uniform(101) / 100.0;
  CGFloat green = arc4random_uniform(101) / 100.0;
  
  _circleColor = [UIColor colorWithRed:red
                                 green:green
                                  blue:blue
                                 alpha:1];
  [self setNeedsDisplay];
}


@end
