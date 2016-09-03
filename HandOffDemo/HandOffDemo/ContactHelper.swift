//
//  ContactHelper.swift
//  HandOffDemo
//
//  Created by 王仕杰 on 9/3/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import Foundation
import CoreData

class ContactHelper {
  private init() { }
  
  static let sharedInstance = ContactHelper()
  
  private let context = CoreDataStack.sharedInstance.managedContext
  
  var allContact: [Contact] {
    get {
      let fetchRequest = NSFetchRequest(entityName: "Contact")
      fetchRequest.sortDescriptors = [NSSortDescriptor(key: "firstName", ascending: true)]
      
//      try! context.executeFetchRequest(fetchRequest) as! [Contact]
      
      do {
        return try context.executeFetchRequest(fetchRequest) as! [Contact]
      } catch let error as NSError {
        print(error.localizedDescription)
      }
      
      return [Contact]()
    }
  }
  
  func insertContact(newContact: Contact) {
    let contact = NSEntityDescription.insertNewObjectForEntityForName("Contact", inManagedObjectContext: context) as! Contact
    
    contact.firstName = newContact.firstName
    contact.lastName = newContact.lastName
    contact.telephoneNumber = newContact.telephoneNumber
    contact.email = newContact.email
    
    CoreDataStack.sharedInstance.saveContext()
  }
  
  func insertContact(firstName firstName: String?, lastName: String?, telephone: String?, email: String?) {
    let newContact = NSEntityDescription.insertNewObjectForEntityForName("Contact", inManagedObjectContext: context) as! Contact
    
    newContact.firstName = firstName
    newContact.lastName = lastName
    newContact.telephoneNumber = telephone
    newContact.email = email
    
    CoreDataStack.sharedInstance.saveContext()
  }
}