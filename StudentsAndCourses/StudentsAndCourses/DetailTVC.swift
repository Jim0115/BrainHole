//
//  CourseOfStudentTVC.swift
//  StudentsAndCourses
//
//  Created by 王仕杰 on 5/23/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class DetailTVC: UITableViewController {
  
  var isStudent = false
  var object: AnyObject = Int()
  var owns: [AnyObject] = [Int()]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItem = editButtonItem()
  }
  
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return owns.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("detail cell", forIndexPath: indexPath)
    if isStudent {
      cell.textLabel?.text = (owns as! [Course])[indexPath.row].courseName // texts[indexPath.row]
      cell.detailTextLabel?.text = (owns as! [Course])[indexPath.row].courseID // details[indexPath.row]
    } else {
      cell.textLabel?.text = (owns as! [Student])[indexPath.row].stuName // texts[indexPath.row]
      cell.detailTextLabel?.text = (owns as! [Student])[indexPath.row].stuID // details[indexPath.row]
    }
    
    return cell
  }
  
  // MARK: - table view delegate
  
  // Override to support conditional editing of the table view.
//  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//    // Return false if you do not want the specified item to be editable.
//    return true
//  }
  
  
  
  // Override to support editing the table view.
//  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//    if editingStyle == .Delete {
//      texts.removeAtIndex(indexPath.row)
//      details.removeAtIndex(indexPath.row)
//      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }
//  }
  
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
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
