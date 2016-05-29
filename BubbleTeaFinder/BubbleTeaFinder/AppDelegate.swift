//
//  AppDelegate.swift
//  BubbleTeaFinder
//
//  Created by 王仕杰 on 5/28/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  lazy var coredataStack = CoreDataStack()


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    let navi = window!.rootViewController as! UINavigationController
    (navi.topViewController as! TeaTVC).coredataStack = coredataStack
    
    getDataFromJsonIfNeeded()
    
    return true
  }
  
  func getDataFromJsonIfNeeded() {
    let request = NSFetchRequest(entityName: "Venue")
    guard try! coredataStack.managedContext.executeFetchRequest(request).count == 0 else {
      return
    }
    
    let json = JSON(data: NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("seed", withExtension: "json")!)!)
    
    for (_, venueJson) in json["response"]["venues"] {
      let newVenue = NSEntityDescription.insertNewObjectForEntityForName("Venue", inManagedObjectContext: coredataStack.managedContext) as! Venue
      newVenue.name = venueJson["name"].string
      newVenue.phone = venueJson["phone"].string
      newVenue.specialCount = venueJson["specials"]["count"].int
      
      let category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: coredataStack.managedContext) as! Category
      category.categoryID = venueJson["categories"][0]["id"].string
      category.name = venueJson["categories"][0]["name"].string
      newVenue.category = category
      
      let location = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: coredataStack.managedContext) as! Location
      location.address = venueJson["location"]["address"].string
      location.city = venueJson["location"]["city"].string
      location.country = venueJson["location"]["country"].string
      location.distance = venueJson["location"]["distance"].int
      location.state = venueJson["location"]["state"].string
      location.zipcode = venueJson["location"]["postalCode"].string
      newVenue.location = location
      
      let priceInfo = NSEntityDescription.insertNewObjectForEntityForName("PriceInfo", inManagedObjectContext: coredataStack.managedContext) as! PriceInfo
      priceInfo.priceCategory = venueJson["price"]["currency"].string
      newVenue.priceInfo = priceInfo
      
      let stats = NSEntityDescription.insertNewObjectForEntityForName("Stats", inManagedObjectContext: coredataStack.managedContext) as! Stats
      stats.checkinsCount = venueJson["stats"]["checkinsCount"].int
      stats.tipCount = venueJson["stats"]["tipCount"].int
      stats.usersCount = venueJson["stats"]["usersCount"].int
      newVenue.stats = stats
      
    }
    
    coredataStack.saveContext()
  }

  func applicationDidEnterBackground(application: UIApplication) {
    coredataStack.saveContext()
  }

  func applicationWillTerminate(application: UIApplication) {
    coredataStack.saveContext()
  }


}

