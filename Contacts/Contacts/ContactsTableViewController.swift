//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by 王仕杰 on 5/17/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit
import CoreData

class ContactsTableViewController: UITableViewController, UISearchBarDelegate {
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
  
  override func viewDidLoad() {
    NSNotificationCenter.defaultCenter().addObserverForName(NSManagedObjectContextDidSaveNotification, object: nil, queue: nil) {
      [unowned self] (_) in self.tableView.reloadData()
    }
  }
  
  var data: [Contact] {
    let request = NSFetchRequest(entityName: "Contact")
    request.sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: true), NSSortDescriptor(key: "firstName", ascending: true)]
    return try! delegate.managedObjectContext.executeFetchRequest(request) as! [Contact]
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("person cell", forIndexPath: indexPath) as! PersonCell
    
    cell.firstNameLabel.text = data[indexPath.row].firstName
    cell.lastNameLabel.text = data[indexPath.row].lastName
    
    return cell
  }
  
  // MARK: - search bar delegate
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    tableView.reloadData()
  }
  
  // MARK: - Table view delegate
  
  //  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
  //    let label = UILabel(frame: CGRect(x: 15, y: 0, width: view.bounds.width - 30, height: 20))
  //    label.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
  ////    label.text = "    " + String(people[section][0].lastName.characters.first!)
  //    label.adjustsFontSizeToFitWidth = true
  //    return label
  //  }
  
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  
  // Override to support editing the table view.
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      delegate.managedObjectContext.deleteObject(data[indexPath.row])
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
  }
 
  
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
  
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  //  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  //
  //  }
  
  func groupByFirstLetter(values: [Person]) -> [[Person]] {
    var ans = [[Person]]()
    let sorted = values.sort { $0.lastName < $1.lastName }
    var tmp = [Person]()
    
    for index in 0..<sorted.count {
      if tmp.isEmpty {
        tmp.append(sorted[index])
      } else {
        if tmp[0].lastName.characters.first == sorted[index].lastName.characters.first {
          tmp.append(sorted[index])
        } else {
          ans.append(tmp)
          tmp = []
          tmp.append(sorted[index])
        }
      }
    }
    if !tmp.isEmpty {
      ans.append(tmp)
    }
    
    return ans
  }
}
