//
//  ViewController.swift
//  ZoomInImageWhenPullingDown
//
//  Created by 王仕杰 on 4/18/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var topOffset: NSLayoutConstraint!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    topOffset.constant = imageView.frame.height
  }
  
  override func viewWillAppear(animated: Bool) {
    scrollView.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
  }
  
  override func viewWillDisappear(animated: Bool) {
    scrollView.removeObserver(self, forKeyPath: "contentOffset")
  }
  
  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    let scaleRate: CGFloat = 200 // higher rate means less zooming
    let limit: CGFloat = -100
    if scrollView.contentOffset.y < 0 && scrollView.contentOffset.y > limit {
      imageView.transform = CGAffineTransformMakeScale(abs(scrollView.contentOffset.y / scaleRate) + 1, abs(scrollView.contentOffset.y / scaleRate) + 1)
    }
  }
}

