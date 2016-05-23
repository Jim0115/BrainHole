//
//  NewStudentVC.swift
//  StudentsAndCourses
//
//  Created by 王仕杰 on 5/23/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit
import CoreData

class NewStudentVC: UIViewController, UITableViewDataSource {
  
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var idField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  
  let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
  
  var courses: [Course] {
    let request = NSFetchRequest(entityName: "Course")
    request.sortDescriptors = [NSSortDescriptor(key: "courseID", ascending: true)]
    return (try! delegate.managedObjectContext.executeFetchRequest(request)) as! [Course]
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
    
    let p = NSPredicate(format: "self matches %@", "^(stu_20)[0-9]{6}$")
    guard p.evaluateWithObject(idField.text!) else {
      idField.backgroundColor = UIColor.redColor()
      return
    }
    idField.backgroundColor = UIColor.whiteColor()
    
    let newStudent = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: delegate.managedObjectContext) as! Student
    newStudent.stuName = nameField.text
    newStudent.stuID = idField.text
    
    let selectedCourses = NSMutableSet()
    if let selectedPaths = tableView.indexPathsForSelectedRows {
      for indexPath in selectedPaths {
        selectedCourses.addObject(courses[indexPath.row])
      }
    }
    
    newStudent.courses = selectedCourses.copy() as? NSSet
    
    delegate.saveContext()
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: - table view data source
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return courses.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("select course cell", forIndexPath: indexPath)
    
    let c = courses[indexPath.row]
    cell.textLabel?.text = c.courseName
    cell.detailTextLabel?.text = c.courseID
    
    return cell
  }
}
