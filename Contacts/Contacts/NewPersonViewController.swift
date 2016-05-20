//
//  NewPersonViewController.swift
//  Contacts
//
//  Created by 王仕杰 on 5/17/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit
import CoreData

class NewPersonViewController: UIViewController {
  
  @IBOutlet weak var doneButton: UIBarButtonItem!
  
  @IBOutlet var textFields: [UITextField]!
  
  let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
  
  @IBAction func cancel(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func done(sender: UIBarButtonItem) {
    view.becomeFirstResponder()
    let newContact = NSEntityDescription.insertNewObjectForEntityForName("Contact", inManagedObjectContext: delegate.managedObjectContext) as! Contact
    for field in textFields {
      switch field.tag {
      case 101:
        newContact.firstName = field.text
      case 102:
        newContact.lastName = field.text
      case 103:
        newContact.phone = field.text
      default:
        break
      }
    }
    delegate.saveContext()
    cancel(self)
  }
  
  
  @IBAction func textChanged(sender: UITextField) {
    doneButton.enabled = textFields.map { !$0.text!.isEmpty }.reduce(false) { $0 || $1 }
  }
  
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // TODO
  }
  
}
