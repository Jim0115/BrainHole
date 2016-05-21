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
  
  var data: [[Contact]] {
    let request = NSFetchRequest(entityName: "Contact")
    if !searchBar.text!.isEmpty {
      request.predicate = NSPredicate(format: "self.firstName contains[cd] %@ or self.lastName contains[cd] %@", searchBar.text!, searchBar.text!)
    }
    request.sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: true), NSSortDescriptor(key: "firstName", ascending: true)]
    return groupByFirstLetter(try! delegate.managedObjectContext.executeFetchRequest(request) as! [Contact])
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return data.count
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data[section].count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("person cell", forIndexPath: indexPath) as! PersonCell
    
    cell.firstNameLabel.text = data[indexPath.section][indexPath.row].firstName
    cell.lastNameLabel.text = data[indexPath.section][indexPath.row].lastName
    
    return cell
  }
  
  // MARK: - search bar delegate
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    tableView.reloadData()
  }
  
  // MARK: - Table view delegate
  
  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel(frame: CGRect(x: 15, y: 0, width: view.bounds.width - 30, height: 20))
    label.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    label.text = "    " + String(data[section][0].lastName!.firstLetterOfMandarinString())
    label.adjustsFontSizeToFitWidth = true
    return label
  }
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  
  // Override to support editing the table view.
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      let count = data[indexPath.section].count
      delegate.managedObjectContext.deleteObject(data[indexPath.section][indexPath.row])
      if count == 1 {
        tableView.deleteSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Automatic)
      } else {
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
      }
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
  
  func groupByFirstLetter(values: [Contact]) -> [[Contact]] {
    var ans = [[Contact]]()
    var tmp = [Contact]()
    
    for index in 0..<values.count {
      if tmp.isEmpty {
        tmp.append(values[index])
      } else {
        if tmp[0].lastName!.firstLetterOfMandarinString() == values[index].lastName!.firstLetterOfMandarinString() {
          tmp.append(values[index])
        } else {
          ans.append(tmp)
          tmp = []
          tmp.append(values[index])
        }
      }
    }
    if !tmp.isEmpty {
      ans.append(tmp)
    }
    
    return ans
  }
}

extension String {
  func firstLetterOfMandarinString() -> String {
    guard !self.isEmpty else { return "#" }
    let s = self.stringByApplyingTransform(NSStringTransformMandarinToLatin, reverse: false)!
    if !NSCharacterSet.letterCharacterSet().characterIsMember(s.utf16.first!) {
      return "#"
    }
    return String(s.characters.first!).uppercaseString
  }
}
