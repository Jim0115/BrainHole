//
//  Contact+CoreDataProperties.swift
//  HandOffDemo
//
//  Created by 王仕杰 on 9/3/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contact {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var telephoneNumber: String?
    @NSManaged var email: String?

}
