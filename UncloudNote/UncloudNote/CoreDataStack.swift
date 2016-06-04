//
//  CoreDataStack.swift
//  UncloudNote
//
//  Created by 王仕杰 on 6/3/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import CoreData

class CoreDataStack {
  private init() { }
  
  static let sharedStack = CoreDataStack()
  
  let modelName = "Model"
  
  lazy var managedObjectModel: NSManagedObjectModel = {
    let url = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd")!
    return NSManagedObjectModel(contentsOfURL: url)!
  }()
  
  private lazy var coordinator: NSPersistentStoreCoordinator = {
    let coor = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    let url = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!.URLByAppendingPathComponent(self.modelName)
    do {
      try coor.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: [NSMigratePersistentStoresAutomaticallyOption : true])
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    
    return coor
  }()
  
  lazy var managedContext: NSManagedObjectContext = {
    let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    context.persistentStoreCoordinator = self.coordinator
    
    return context
  }()
  
  func saveContext() {
    do {
      try managedContext.save()
    } catch let error as NSError {
      print(error.localizedDescription)
    }
  }
}