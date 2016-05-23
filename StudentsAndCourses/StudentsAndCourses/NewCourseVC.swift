//
//  NewCourseVC.swift
//  StudentsAndCourses
//
//  Created by 王仕杰 on 5/23/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit
import CoreData

class NewCourseVC: UIViewController, UITableViewDataSource {
  
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var idField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  
  let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
  
  var students: [Student] {
    let request = NSFetchRequest(entityName: "Student")
    request.sortDescriptors = [NSSortDescriptor(key: "stuID", ascending: true)]
    return (try! delegate.managedObjectContext.executeFetchRequest(request)) as! [Student]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.editing = true
  }
  
  @IBAction func cancel() {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func save() {
    guard !nameField.text!.isEmpty else {
      nameField.backgroundColor = UIColor.redColor()
      return
    }
    nameField.backgroundColor = UIColor.whiteColor()
    
    let p = NSPredicate(format: "self matches %@", "^(course_)[0-9]{6}$")
    guard p.evaluateWithObject(idField.text!) else {
      idField.backgroundColor = UIColor.redColor()
      return
    }
    idField.backgroundColor = UIColor.whiteColor()
    
    let newCourse = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: delegate.managedObjectContext) as! Course
    newCourse.courseName = nameField.text
    newCourse.courseID = idField.text
    
    let selectedCourses = NSMutableSet()
    if let selectedPaths = tableView.indexPathsForSelectedRows {
      for indexPath in selectedPaths {
        selectedCourses.addObject(students[indexPath.row])
      }
    }
    
    newCourse.students = selectedCourses.copy() as? NSSet
    
    delegate.saveContext()
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: - table view data source
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return students.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("select course cell", forIndexPath: indexPath)
    
    let s = students[indexPath.row]
    cell.textLabel?.text = s.stuName
    cell.detailTextLabel?.text = s.stuID
    
    return cell
  }
}
