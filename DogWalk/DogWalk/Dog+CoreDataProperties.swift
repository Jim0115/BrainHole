//
//  Dog+CoreDataProperties.swift
//  DogWalk
//
//  Created by 王仕杰 on 5/27/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Dog {

    @NSManaged var name: String?
    @NSManaged var walks: NSOrderedSet?

}
