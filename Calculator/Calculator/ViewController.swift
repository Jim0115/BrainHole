//
//  ViewController.swift
//  Calculator
//
//  Created by 王仕杰 on 5/11/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var screen: UILabel!
  
  
  @IBAction func appendDigit(sender: UIButton) {
    if screen.text! == "0" {
      screen.text = sender.currentTitle
    } else {
      screen.text?.appendContentsOf(sender.currentTitle!)
    }
  }
  
}

