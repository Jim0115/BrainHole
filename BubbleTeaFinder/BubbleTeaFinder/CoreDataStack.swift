//
//  CoreDataStack.swift
//  BubbleTeaFinder
//
//  Created by 王仕杰 on 5/28/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import CoreData
import Foundation

class CoreDataStack {

  let modelName = "BubbleTeaFinder"

  private lazy var userDocumentDirectory: NSURL = {
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return urls.last!
  }()
  
  private lazy var managedObjectModel: NSManagedObjectModel = {
    let url = NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd")!
    return NSManagedObjectModel(contentsOfURL: url)!
  }()
  
  lazy var coordinator: NSPersistentStoreCoordinator = {
    let coordinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    let url = self.userDocumentDirectory.URLByAppendingPathComponent(self.modelName)
    
    let options = [NSMigratePersistentStoresAutomaticallyOption : true]
    
    do {
      try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options)
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    
    return coordinator
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
      abort()
    }
  }
}