//
//  ViewController.swift
//  QuickStart
//
//  Created by 王仕杰 on 7/8/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var field: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  @IBAction func open() {
    let url = NSURL(string: field.text!)!
    UIApplication.sharedApplication().openURL(url)
  }
  
  
}

