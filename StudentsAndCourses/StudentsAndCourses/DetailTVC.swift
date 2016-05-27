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
      return CDHelper.allCourses.map { $0 as SAC }.sort { $0.id < $1.id }
    } else {
      return CDHelper.allStudents.map { $0 as SAC }.sort { $0.id < $1.id }
    }
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItem = editButtonItem()
  }
  
  override func setEditing(editing: Bool, animated: Bool) {
    var indexPaths = [NSIndexPath]()
    if !editing {
      let indexPaths = tableView.indexPathsForSelectedRows ?? [NSIndexPath]()
      var tmp = [SAC]()
      for i in (indexPaths.map { $0.row }) {
        tmp.append(allObject[i])
      }
      object.owns = tmp.sort { $0.id < $1.id }
      
    } else {
      for i in object.owns! {
        indexPaths.append(NSIndexPath(forRow: allObject.indexOf { $0.id == i.id }!, inSection:0))
      }
    }
    super.setEditing(editing, animated: animated)
    tableView.reloadData()
    if editing {
      for indexPath in indexPaths {
        tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
      }
      indexPaths.removeAll()
    }
  }
  
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableView.editing ? allObject.count : object.owns!.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("detail cell", forIndexPath: indexPath)
    
    let obj = tableView.editing ? allObject[indexPath.row] : object.owns![indexPath.row]
    cell.textLabel?.text = obj.name // texts[indexPath.row]
    cell.detailTextLabel?.text = obj.id // details[indexPath.row]
    
    return cell
  }

}