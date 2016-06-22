//
//  YellowView.swift
//  XIBDemo
//
//  Created by 王仕杰 on 6/22/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class YellowView: UIView {

  @IBOutlet weak var label: UILabel!
  
  
  override func awakeFromNib() {
    backgroundColor = UIColor.yellowColor()
    label.text = "Yellow"
  }
}
