//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by 王仕杰 on 5/17/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
  
  var people = Array(arrayLiteral: Person(firstName: "Shijie", lastName: "Wang", phoneNumber: "1234567890123")) {
    didSet {
      people.sortInPlace { $0.lastName < $1.lastName }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("person cell", forIndexPath: indexPath) as! PersonCell
    
    cell.firstNameLabel.text = people[indexPath.row].firstName
    cell.lastNameLabel.text = people[indexPath.row].lastName
    
    return cell
  }
  
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
   if editingStyle == .Delete {
   // Delete the row from the data source
   tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
   } else if editingStyle == .Insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  // MARK: - Navigation
  
  @IBAction func appendNewPerson(segue: UIStoryboardSegue) {
    tableView.reloadData()
  }
  
   
  // In a storyboard-based application, you will often want to do a little preparation before navigation
//  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    
//  }
  
  
}
