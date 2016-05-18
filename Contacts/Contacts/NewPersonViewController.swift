//
//  NewPersonViewController.swift
//  Contacts
//
//  Created by 王仕杰 on 5/17/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class NewPersonViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var addPhotoButton: UIButton!
  
  
  @IBOutlet weak var doneButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addPhotoButton.setTitle("add\nphoto", forState: .Normal)
  }
  
  
  @IBAction func cancel(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // TODO
  }
  
}
