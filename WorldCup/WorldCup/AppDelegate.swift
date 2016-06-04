//
//  AppDelegate.swift
//  WorldCup
//
//  Created by 王仕杰 on 5/30/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  let coreDataStack = CoreDataStack.sharedStack

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    initialDataIfNeeded()
    return true
  }

  func initialDataIfNeeded() {
    let fetchRequest = NSFetchRequest(entityName: "Team")
    var e: NSError?
    if coreDataStack.managedContext.countForFetchRequest(fetchRequest, error: &e) != 0 { return }
    
    let dataURL = NSBundle.mainBundle().URLForResource("seed", withExtension: "json")!
    let newDataJson = JSON(data: NSData(contentsOfURL: dataURL)!)
    
    for (_, teamJson) in newDataJson {
      let newTeam = NSEntityDescription.insertNewObjectForEntityForName("Team", inManagedObjectContext: coreDataStack.managedContext) as! Team
      
      newTeam.imageName = teamJson["imageName"].string
      newTeam.teamName = teamJson["teamName"].string
      newTeam.qualifyingZone = teamJson["qualifyingZone"].string
      newTeam.wins = teamJson["wins"].int
      
      coreDataStack.saveContext()
    }
    print("imported \(newDataJson.count) teams")
  }

}

