//
//  DetailViewController.swift
//  HandOffDemo
//
//  Created by 王仕杰 on 9/4/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
  var contact: Contact?
  
  let titles = ["FirstName", "LastName", "Telephone", "Email"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.reloadData()
  }
  
  // MARK: - table view data source
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("idCellContact", forIndexPath: indexPath)
    
    switch indexPath.row {
    case 0:
      cell.detailTextLabel?.text = contact?.firstName
    case 1:
      cell.detailTextLabel?.text = contact?.lastName
    case 2:
      cell.detailTextLabel?.text = contact?.telephoneNumber
    case 3:
      cell.detailTextLabel?.text = contact?.email
    default:
      fatalError()
    }
    
    cell.textLabel?.text = titles[indexPath.row]
    
    return cell
  }

}
