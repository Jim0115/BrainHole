//
//  Student.swift
//  StudentsAndCourses
//
//  Created by 王仕杰 on 5/22/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import Foundation
import CoreData


class Student: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

}

extension Student: SAC {
  var name: String? {
    get {
      return stuName
    }
    set {
      stuName = newValue
    }
  }
  
  var id: String? {
    get {
      return stuID
    }
    set {
      stuID = newValue
    }
  }
  
  var owns: [SAC]? {
    get {
      return courses?.allObjects.map { $0 as! Course }
    }
    set {
      courses = NSSet(array: newValue!.map { $0 as AnyObject })
    }
  }
}