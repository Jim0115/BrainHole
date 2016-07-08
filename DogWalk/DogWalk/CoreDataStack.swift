//
//  CoreDataStack.swift
//  DogWalk
//
//  Created by 王仕杰 on 5/27/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//
import CoreData

//class CoreDataStack {
//  let modelName = "DogWalk"
//  
//  private lazy var applicationDocumentsDirectory: NSURL = {
//    let manager = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
//    return manager.last!
//  }()
//  
//  lazy var context: NSManagedObjectContext = {
//    var context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
//    context.persistentStoreCoordinator = self.psc
//    return context
//  }()
//  
//  lazy var psc: NSPersistentStoreCoordinator = {
//    let coodinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
//    let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent(self.modelName)
//    do {
//      let options = [NSMigratePersistentStoresAutomaticallyOption : true]
//      try coodinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options)
//    } catch let error {
//      print(error)
//    }
//    return coodinator
//  }()
//  
//  private lazy var managedObjectModel: NSManagedObjectModel = {
//    let modelURL = NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd")!
//    return NSManagedObjectModel(contentsOfURL: modelURL)!
//  }()
//  
//  func saveContext() {
//    if context.hasChanges {
//      do {
//        try context.save()
//      } catch let error as NSError {
//        print(error.localizedDescription)
//        abort()
//      }
//    }
//  }
//}

class CoreDataStack {
  let modelName = "DogWalk"
  
  private lazy var applicationDocumentDirectory: NSURL = {
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return urls.last!
  }()
  
  lazy var managedContext: NSManagedObjectContext = {
    let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    context.persistentStoreCoordinator = self.psc
    
    return context
  }()
  
  lazy var psc: NSPersistentStoreCoordinator = {
    let coodinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    let url = self.applicationDocumentDirectory.URLByAppendingPathComponent(self.modelName)
    
    do {
      let option = [NSMigratePersistentStoresAutomaticallyOption : true]
      try coodinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: option)
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    
    return coodinator
  }()
  
  private lazy var managedObjectModel: NSManagedObjectModel = {
    let modelURL = NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd")!
    return NSManagedObjectModel(contentsOfURL: modelURL)!
  }()
  
  func saveContext() {
    do {
      try managedContext.save()
    } catch let error as NSError {
      print(error.localizedDescription)
      abort()
    }
  }
}