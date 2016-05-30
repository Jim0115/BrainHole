//
//  Team+CoreDataProperties.swift
//  WorldCup
//
//  Created by 王仕杰 on 5/30/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Team {

    @NSManaged var imageName: String?
    @NSManaged var losses: NSNumber?
    @NSManaged var teamName: String?
    @NSManaged var wins: NSNumber?
    @NSManaged var qualifyingZone: String?

}
