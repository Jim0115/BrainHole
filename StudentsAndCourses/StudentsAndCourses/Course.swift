//
//  Course.swift
//  StudentsAndCourses
//
//  Created by 王仕杰 on 5/22/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import Foundation
import CoreData


class Course: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

}

extension Course: SAC {
  var name: String? {
    get {
      return courseName
    }
    set {
      courseName = newValue
    }
  }
  
  var id: String? {
    get {
      return courseID
    }
    set {
      courseID = newValue
    }
  }
  
  var owns: [SAC]? {
    get {
      return students!.allObjects.map { $0 as! Student }
    }
    set {
      students = NSSet(array: newValue!.map { $0 as AnyObject })
    }
  }
}