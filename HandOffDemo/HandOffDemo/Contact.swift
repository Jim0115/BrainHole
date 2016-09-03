//
//  Contact.swift
//  HandOffDemo
//
//  Created by 王仕杰 on 9/3/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import Foundation
import CoreData


class Contact: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
  
  override var description: String {
    return ["firstName" : firstName ?? "Not Set",
            "lastName" : lastName ?? "Not Set",
            "telephone" : telephoneNumber ?? "Not Set",
            "email" : email ?? "Not Set"].description
  }

}
