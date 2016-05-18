//
//  Person.swift
//  Contacts
//
//  Created by 王仕杰 on 5/17/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import Foundation

class Person {
  var firstName = ""
  var lastName = ""
  var phoneNumber = ""
  
  init() { }
  
  init(firstName: String?, lastName: String?, phoneNumber: String?) {
    self.firstName = firstName ?? ""
    self.lastName = lastName ?? ""
    self.phoneNumber = phoneNumber ?? ""
  }
}