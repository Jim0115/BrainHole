//
//  ViewController.swift
//  XIBDemo
//
//  Created by 王仕杰 on 6/22/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    
    let viewFromXib = NSBundle.mainBundle().loadNibNamed("Generic", owner: nil, options: nil)[0] as! YellowView
    viewFromXib.translatesAutoresizingMaskIntoConstraints = false
//    viewFromXib.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
    view.addSubview(viewFromXib)
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[view(300)]", options: [], metrics: ["width" : self.view.frame.height / 2], views: ["view" : viewFromXib]))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-100-[view(120)]", options: [], metrics: nil, views: ["view" : viewFromXib]))
  }
}

