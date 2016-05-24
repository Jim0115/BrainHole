//
//  CourseTVC.swift
//  StudentsAndCourses
//
//  Created by 王仕杰 on 5/22/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class CourseTVC: UITableViewController {
  
  let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
  
  var courses: [Course] {
    return CDHelper.allCourses
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return courses.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("course cell", forIndexPath: indexPath)
    
    let c = courses[indexPath.row]
    cell.textLabel?.text = c.courseName
    cell.detailTextLabel?.text = c.courseID
//    print("the last student of \(c.courseName!) is \((c.students!.allObjects.last as! Student).stuName)")
    
    return cell
  }
  
  // MARK: - table view delegate
  
  // Override to support conditional editing of the table view.
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }
  
  
  
  // Override to support editing the table view.
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      delegate.managedObjectContext.deleteObject(courses[indexPath.row])
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
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard segue.identifier == "show detail" else { return }
    let destination = segue.destinationViewController as! DetailTVC
    let index = tableView.indexPathForSelectedRow!.row
    destination.title = "Students of " + courses[index].courseName!
    let students = courses[index].students!.allObjects as! [Student]
//    destination.texts = students.map { $0.stuName! }
//    destination.details = students.map { $0.stuID! }
    destination.object = courses[index]
    destination.owns = students
    destination.isStudent = false
  }
  
  
}
