//
//  Venue+CoreDataProperties.swift
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

extension Venue {

    @NSManaged var favorite: NSNumber?
    @NSManaged var name: String?
    @NSManaged var phone: String?
    @NSManaged var specialCount: NSNumber?
    @NSManaged var category: Category?
    @NSManaged var location: Location?
    @NSManaged var priceInfo: PriceInfo?
    @NSManaged var stats: Stats?

}
