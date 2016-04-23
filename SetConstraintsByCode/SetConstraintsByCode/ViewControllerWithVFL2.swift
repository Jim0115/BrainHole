//
//  ViewControllerWithVFL2.swift
//  SetConstraintsByCode
//
//  Created by 王仕杰 on 4/23/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class ViewControllerWithVFL2: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let redView = UIView()
    redView.backgroundColor = UIColor.redColor()
    redView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(redView)
    
    
    
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[view]-tabbarHeight-|", options: .AlignAllCenterX, metrics: ["tabbarHeight" : tabBarController!.tabBar.frame.height], views: ["view" : redView]))
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]-0-|", options: .AlignAllCenterY, metrics: nil, views: ["view" : redView]))
  }
  
}
