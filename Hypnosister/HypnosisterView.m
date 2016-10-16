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
  
  UIBezierPath* path = [UIBezierPath new];
  
  for (CGFloat currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
    [path addArcWithCenter:self.center
                    radius:currentRadius
                startAngle:0
                  endAngle:M_PI * 2
                 clockwise:YES];
    [path moveToPoint:CGPointMake(self.bounds.size.width / 2 + currentRadius - 20, self.center.y)];
  }
  
  path.lineWidth = 10;
  
  [[UIColor lightGrayColor] setStroke];
  
  [path stroke];
}


@end
