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
    
    print(presentingViewController)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    createUserActivity()
  }
  
  // MARK: - NSUserActivity

  func createUserActivity() {
    userActivity = NSUserActivity(activityType: "cn.wangshijie.HandOffDemo.newContact")
    
    userActivity?.title = "New Contact"
    userActivity?.becomeCurrent()
  }
  
  override func updateUserActivityState(activity: NSUserActivity) {
    userActivity?.addUserInfoEntriesFromDictionary(["firstName": firstNameField.text ?? "",
      "telephone": phoneNumberField.text ?? "",
      "email": emailField.text ?? "",
      "lastName": lastNameField.text ?? ""])
    
    super.updateUserActivityState(activity)
  }
  
  override func restoreUserActivityState(activity: NSUserActivity) {
    if let userinfo = activity.userInfo {
      firstNameField?.text = userinfo["firstName"] as? String
      lastNameField?.text = userinfo["lastName"] as? String
      phoneNumberField?.text = userinfo["telephone"] as? String
      emailField?.text = userinfo["email"] as? String
    }
  }
  
  
  // MARK: - UITextFieldDelegate
  
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
    
    userActivity?.needsSave = true
    
    return true
  }
  
  // MARK: - IBActions
  
  @IBAction func cancelAddingNewContact(sender: UIBarButtonItem) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard segue.identifier == "idSegueDidAddNewContact" else { return }
    guard segue.destinationViewController is ContactsViewController else { return }
    
    userActivity?.invalidate()
    ContactHelper.sharedInstance.insertContact(firstName: firstNameField.text, lastName: lastNameField.text, telephone: phoneNumberField.text, email: emailField.text)
  }
  
}
