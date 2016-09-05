//
//  ContactsViewController.swift
//  HandOffDemo
//
//  Created by 王仕杰 on 9/3/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
  lazy var allContacts: [Contact] = {
    return ContactHelper.sharedInstance.allContacts
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = 60
    tableView.estimatedRowHeight = 60

  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
  }
  
  // MARK: - NSUserActivity
  
//  override func restoreUserActivityState(activity: NSUserActivity) {
//    
//    userActivity = activity
//    
//    if activity.activityType == "cn.wangshijie.HandOffDemo.newContact" {
//      self.performSegueWithIdentifier("idSeguePersentAddContact", sender: self)
//    }
//    
//    super.restoreUserActivityState(activity)
//  }
  
  // MARK: - table view data source
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allContacts.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("idCellContact", forIndexPath: indexPath)
    
    let contact = allContacts[indexPath.row]
    
    cell.textLabel?.text = (contact.firstName ?? "FIRST_NAME_NOT_SET") + " " + (contact.lastName ?? "LAST_NAME_NOT_SET")
    
    return cell
  }
  
  @IBAction func didAddNewContact(segue: UIStoryboardSegue) {
    allContacts = ContactHelper.sharedInstance.allContacts
    tableView.reloadData()
  }
  
  
  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "idSegueShowDetail" {
      if let destination = segue.destinationViewController as? DetailViewController {
        let row = tableView.indexPathForCell(sender as! UITableViewCell)!.row
        destination.contact = allContacts[row]
      }
    }
  }
  
}
