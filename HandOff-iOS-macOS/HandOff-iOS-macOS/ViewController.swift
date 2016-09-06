//
//  ViewController.swift
//  HandOff-iOS-macOS
//
//  Created by 王仕杰 on 9/6/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var addressField: UITextField!
  @IBOutlet weak var indicatorView: UIActivityIndicatorView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    userActivity = NSUserActivity(activityType: "cn.edu.neu.wangshijie.HandOff-iOS-macOS.updateURL")
    userActivity?.becomeCurrent()
    
    indicatorView.hidesWhenStopped = true
    indicatorView.stopAnimating()
  }
  
  @IBAction func goAction(sender: UIButton) {
    if let text = addressField.text {
      if let persentedText = text.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet()) {
        userActivity?.webpageURL = NSURL(string: "https://www.baidu.com/s?wd=" + persentedText)
      }
    }
    
    sender.hidden = true
    indicatorView.startAnimating()
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 5)), dispatch_get_main_queue()) {
      self.indicatorView.stopAnimating()
      sender.hidden = false
    }
  }
  

}

