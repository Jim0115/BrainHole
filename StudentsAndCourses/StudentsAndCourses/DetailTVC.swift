//
//  CourseOfStudentTVC.swift
//  StudentsAndCourses
//
//  Created by 王仕杰 on 5/23/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class DetailTVC: UITableViewController {
  
  var object: SAC!
  lazy var allObject: [SAC] = {
    if self.object is Student {
      return CDHelper.allCourses.map { $0 as SAC }
    } else {
      return CDHelper.allStudents.map { $0 as SAC }
    }
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: #selector(DetailTVC.changeEdit(_:)))
  }
  
  func changeEdit(sender: UIBarButtonItem) {
    tableView.editing = !tableView.editing
    tableView.reloadData()
    
    if tableView.editing {
      sender.title = "Done"
      sender.style = .Done
    } else {
      sender.title = "Edit"
      sender.style = .Plain
    }
  }
  
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView.editing {
      return allObject.count
    }
    return object.owns!.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("detail cell", forIndexPath: indexPath)
    
    let obj = tableView.editing ? allObject[indexPath.row] : object.owns![indexPath.row]
//    print(editing)
    cell.textLabel?.text = obj.name // texts[indexPath.row]
    cell.detailTextLabel?.text = obj.id // details[indexPath.row]
    
    return cell
  }

}

extension Array {
}