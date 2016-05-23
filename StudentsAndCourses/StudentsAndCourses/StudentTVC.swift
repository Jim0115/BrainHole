//
//  StudentTVC.swift
//  StudentsAndCourses
//
//  Created by 王仕杰 on 5/22/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit
import CoreData

class StudentTVC: UITableViewController {
  
  let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
  
  var students: [Student] {
    let request = NSFetchRequest(entityName: "Student")
    request.sortDescriptors = [NSSortDescriptor(key: "stuID", ascending: true)]
    return (try! delegate.managedObjectContext.executeFetchRequest(request)) as! [Student]
  }
  
  override func viewWillAppear(animated: Bool) {
    tableView.reloadData()
  }
  
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return students.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("student cell", forIndexPath: indexPath)
    
    let s = students[indexPath.row]
    cell.textLabel?.text = s.stuName
    cell.detailTextLabel?.text = s.stuID
    
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
      delegate.managedObjectContext.deleteObject(students[indexPath.row])
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
    guard segue.identifier == "show cos" else { return }
    let destination = segue.destinationViewController as! DetailTVC
    let index = tableView.indexPathForSelectedRow!.row
    destination.title = "Courses of " + students[index].stuName!
    let courses = students[index].courses!.allObjects as! [Course]
    destination.texts = courses.map { $0.courseName! }
    destination.details = courses.map { $0.courseID! }
  }
  
  
}
