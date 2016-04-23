//
//  ViewControllerWithVFL.swift
//  SetConstraintsByCode
//
//  Created by 王仕杰 on 4/23/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class ViewControllerWithVFL: UIViewController {
  
  var colorfulViews = [UIView]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    createViews()
    
    for v in colorfulViews { view.addSubview(v) }
    
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
    let viewDict = ["red" : colorfulViews[0], "green" : colorfulViews[1], "yellow" : colorfulViews[2], "blue" : colorfulViews[3]]
    // Horizontal Spacing
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[red]-[green]-[yellow]-[blue]-|", options: .AlignAllTop, metrics: nil, views: viewDict))
    // Vertially Center
    view.addConstraint(NSLayoutConstraint(item: colorfulViews[0], attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0))
    for v in colorfulViews {
      v.addConstraint(NSLayoutConstraint(item: v, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Height, multiplier: 1, constant: 0))
    }
    for i in 1...3 {
      view.addConstraint(NSLayoutConstraint(item: colorfulViews[i], attribute: .Width, relatedBy: .Equal, toItem: colorfulViews[i - 1], attribute: .Width, multiplier: 1, constant: 0))
    }
  }
}
