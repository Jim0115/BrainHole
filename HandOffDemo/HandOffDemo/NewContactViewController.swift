//
//  NewContactViewController.swift
//  HandOffDemo
//
//  Created by 王仕杰 on 9/4/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class NewContactViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var firstNameField: UITextField!
  @IBOutlet weak var lastNameField: UITextField!
  @IBOutlet weak var phoneNumberField: UITextField!
  @IBOutlet weak var emailField: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    switch textField {
    case firstNameField:
      lastNameField.becomeFirstResponder()
    case lastNameField:
      phoneNumberField.becomeFirstResponder()
    case phoneNumberField:
      emailField.becomeFirstResponder()
    case emailField:
      view.endEditing(false)
    default:
      fatalError("wrong text field")
    }
    
    return true
  }
  
  @IBAction func cancelAddingNewContact(sender: UIBarButtonItem) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard segue.identifier == "idSegueDidAddNewContact" else { return }
    guard segue.destinationViewController is ContactsViewController else { return }
    
    ContactHelper.sharedInstance.insertContact(firstName: firstNameField.text, lastName: lastNameField.text, telephone: phoneNumberField.text, email: emailField.text)
  }
  
}
