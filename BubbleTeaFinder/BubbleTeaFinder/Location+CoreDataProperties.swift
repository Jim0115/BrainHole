//
//  Location+CoreDataProperties.swift
//  BubbleTeaFinder
//
//  Created by 王仕杰 on 5/28/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {

    @NSManaged var address: String?
    @NSManaged var city: String?
    @NSManaged var country: String?
    @NSManaged var distance: NSNumber?
    @NSManaged var state: String?
    @NSManaged var zipcode: String?
    @NSManaged var venue: Venue?

}
