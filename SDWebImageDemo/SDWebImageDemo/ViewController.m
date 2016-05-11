//
//  ViewController.m
//  SDWebImageDemo
//
//  Created by 王仕杰 on 5/7/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+WebCache.h>

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic) UIImageView* imageView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (UIImageView *)imageView {
  if (!_imageView) {
    _imageView = [[UIImageView alloc] init];
  }
  return _imageView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.scrollView addSubview:self.imageView];
  self.scrollView.maximumZoomScale = 2;
  self.scrollView.minimumZoomScale = 0.3;
  NSURL* url = [NSURL URLWithString:@"https://pbs.twimg.com/media/Chxt26SVEAEaHEB.jpg:large"];
  [self.imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    [self.imageView sizeToFit];
    if (!error) self.scrollView.contentSize = image.size;
  }];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return self.imageView;
}
@end
