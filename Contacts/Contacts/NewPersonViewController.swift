//
//  NewPersonViewController.swift
//  Contacts
//
//  Created by 王仕杰 on 5/17/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class NewPersonViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var firstNameField: UITextField!
  @IBOutlet weak var lastNameField: UITextField!
  @IBOutlet weak var phoneField: UITextField!
  
  @IBOutlet weak var doneButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  
  @IBAction func cancel(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func textChanged(sender: UITextField) {
    doneButton.enabled = !(firstNameField.text!.isEmpty && lastNameField.text!.isEmpty && phoneField.text!.isEmpty)
  }
  
  // mark: - UITextFieldDelegate
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    switch textField {
    case firstNameField:
      lastNameField.becomeFirstResponder()
    case lastNameField:
      phoneField.becomeFirstResponder()
    default:
      break
    }
    return true
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    firstNameField.becomeFirstResponder()
    firstNameField.resignFirstResponder()
    
    if segue.identifier == "append person" {
      let destination = segue.destinationViewController as! ContactsTableViewController
      destination.data.append(Person(firstName: firstNameField.text, lastName: lastNameField.text, phoneNumber: phoneField.text))
    }
  }
  
  
}
