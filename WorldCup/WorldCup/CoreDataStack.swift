//
//  CoreDataStack.swift
//  WorldCup
//
//  Created by 王仕杰 on 5/30/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import CoreData

class CoreDataStack {
  
  static let sharedStack = CoreDataStack()
  
  private init() { }
  
  private let modelName = "WorldCup"
  
  private lazy var userDocumentDirectory: NSURL = {
    let url = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return url.last!
  }()

  lazy var managedObjectModel: NSManagedObjectModel = {
    let modelURL = NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd")!
    return NSManagedObjectModel(contentsOfURL: modelURL)!
  }()
  
  private lazy var coordinator: NSPersistentStoreCoordinator = {
    let coor: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    
    let url = self.userDocumentDirectory.URLByAppendingPathComponent(self.modelName)
    let option = [NSMigratePersistentStoresAutomaticallyOption : true]
    do {
      try coor.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: option)
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    
    return coor
  }()
  
  lazy var managedContext: NSManagedObjectContext = {
    let managedContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    managedContext.persistentStoreCoordinator = self.coordinator
    
    return managedContext
  }()
  
  func saveContext() {
    do {
      try managedContext.save()
    } catch let error as NSError {
      print(error.localizedDescription)
    }
  }
}