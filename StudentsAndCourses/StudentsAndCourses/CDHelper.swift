//
//  CDHelper.swift
//  StudentsAndCourses
//
//  Created by 王仕杰 on 5/24/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit
import CoreData

public class CDHelper {
  
  private static let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
  
  static var allStudents: [Student] {
    get {
      let request = NSFetchRequest(entityName: "Student")
      request.sortDescriptors = [NSSortDescriptor(key: "stuID", ascending: true)]
      do {
        return try delegate.managedObjectContext.executeFetchRequest(request) as! [Student]
      } catch let error {
        fatalError((error as NSError).localizedDescription)
      }
    }
  }
  
  static var allCourses: [Course] {
    get {
      let request = NSFetchRequest(entityName: "Course")
      request.sortDescriptors = [NSSortDescriptor(key: "CourseID", ascending: true)]
      do {
        return try delegate.managedObjectContext.executeFetchRequest(request) as! [Course]
      } catch let error {
        fatalError((error as NSError).localizedDescription)
      }
    }
  }
  
  static func appendNewStudent(stuID: String, stuName: String, courses: [Course]) {
    let newStudent = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: delegate.managedObjectContext) as! Student
    newStudent.stuID = stuID
    newStudent.stuName = stuName
    newStudent.courses = NSSet(array: courses)
    
    delegate.saveContext()
  }
  
  static func appendNewCourse(courseID: String, courseName: String, students: [Student]) {
    let newCourse = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: delegate.managedObjectContext) as! Course
    newCourse.courseID = courseID
    newCourse.courseName = courseName
    newCourse.students = NSSet(array: students)
    
    delegate.saveContext()
  }
}