//
//  ViewController.swift
//  SetConstraintsByCode
//
//  Created by 王仕杰 on 4/23/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var colorfulViews = [UIView]()
  
  let standardSpacingBetweenViews: CGFloat = 8.0
  let standardSpacingWithSuperView: CGFloat = 20
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    createViews()
    
    for v in colorfulViews {
      view.addSubview(v)
    }
    
    addConstraints()
  
  }

  
  func createViews() {
    let redView = UIView()
    redView.backgroundColor = UIColor.redColor()
    redView.translatesAutoresizingMaskIntoConstraints = false
    colorfulViews.append(redView)
    let greenView = UIView()
    greenView.backgroundColor = UIColor.greenColor()
    greenView.translatesAutoresizingMaskIntoConstraints = false
    colorfulViews.append(greenView)
    let yellowView = UIView()
    yellowView.backgroundColor = UIColor.yellowColor()
    yellowView.translatesAutoresizingMaskIntoConstraints = false
    colorfulViews.append(yellowView)
    let blueView = UIView()
    blueView.backgroundColor = UIColor.blueColor()
    blueView.translatesAutoresizingMaskIntoConstraints = false
    colorfulViews.append(blueView)
  }
  
  func addConstraints() {
    // aspect ratio
    for v in colorfulViews {
      v.addConstraint(NSLayoutConstraint(item: v, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Height, multiplier: 1, constant: 0))
    // vertically center
      view.addConstraint(NSLayoutConstraint(item: v, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0))
    }
    
    for i in 1...3 {
      // spacing
      view.addConstraint(NSLayoutConstraint(item: colorfulViews[i], attribute: .Leading, relatedBy: .Equal, toItem: colorfulViews[i - 1], attribute: .Trailing, multiplier: 1, constant: standardSpacingBetweenViews))
      // equal width
      view.addConstraint(NSLayoutConstraint(item: colorfulViews[i], attribute: .Width, relatedBy: .Equal, toItem: colorfulViews[i - 1], attribute: .Width, multiplier: 1, constant: 0))
    }
    // first and last
    view.addConstraint(NSLayoutConstraint(item: colorfulViews[0], attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: standardSpacingWithSuperView))
    view.addConstraint(NSLayoutConstraint(item: colorfulViews[3], attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: -standardSpacingWithSuperView))
  }
  
}

