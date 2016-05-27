//
//  AppDelegate.swift
//  DogWalk
//
//  Created by 王仕杰 on 5/27/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  lazy var coredateStack = CoreDataStack()
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    let navigationVC = window!.rootViewController as! UINavigationController
    (navigationVC.topViewController as! ViewController).managedContext = coredateStack.context
    
    return true
  }

  func applicationDidEnterBackground(application: UIApplication) {
    coredateStack.saveContext()
  }

  func applicationWillTerminate(application: UIApplication) {
    coredateStack.saveContext()
  }


}

