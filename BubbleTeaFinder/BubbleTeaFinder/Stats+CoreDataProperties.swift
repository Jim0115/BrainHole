//
//  Stats+CoreDataProperties.swift
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

extension Stats {

    @NSManaged var checkinsCount: NSNumber?
    @NSManaged var tipCount: NSNumber?
    @NSManaged var usersCount: NSNumber?
    @NSManaged var venue: Venue?

}
