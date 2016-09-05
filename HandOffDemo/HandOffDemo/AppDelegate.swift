//
//  AppDelegate.swift
//  HandOffDemo
//
//  Created by 王仕杰 on 9/3/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
//    if ContactHelper.sharedInstance.allContact.count == 1 {
//      ContactHelper.sharedInstance.insertContact(email: "testEmail")
//    }
    
//    ContactHelper.sharedInstance.clearAllContact()
    
    print("Current Contacts:")
    print(ContactHelper.sharedInstance.allContacts)
    
    return true
  }
  
  func application(application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
    print("userActivityType " + userActivityType)
    return false
  }
  
  func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
//    if let window = window {
      let navigationVC = window?.rootViewController as? UINavigationController
      let viewController = navigationVC?.topViewController as? ContactsViewController
      
      if viewController?.presentedViewController == nil {
        let newNavi = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("newContactNavi") as! UINavigationController
        viewController?.presentViewController(newNavi, animated: true, completion: nil)
        
        restorationHandler([newNavi.topViewController!])
      } else {
        if let newContactVC = (viewController?.presentedViewController as? UINavigationController)?.topViewController as? NewContactViewController {
          restorationHandler([newContactVC])
        }
      }
      
      
      
      return true
//    } else {
//      return false
//    }
    
    
  }
}

