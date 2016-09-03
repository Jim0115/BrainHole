//
//  CoreDataStack.swift
//  HandOffDemo
//
//  Created by 王仕杰 on 9/3/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import Foundation

import CoreData

public class CoreDataStack {
  private init() { }
  
  public static let sharedInstance = CoreDataStack()
  
  private let modelName = "HandOffModel"
  
  private lazy var userDocumentDirectory: NSURL = {
    let url = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return url[0]
  }()
  
  lazy var managedObjectModel: NSManagedObjectModel = {
    let modelURL = NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd")!
    return NSManagedObjectModel(contentsOfURL: modelURL)!
  }()
  
  private lazy var coordinator: NSPersistentStoreCoordinator = {
    let coor = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    
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
    let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    context.persistentStoreCoordinator = self.coordinator
    
    return context
  }()
  
  func saveContext() {
    try! managedContext.save()
  }
}