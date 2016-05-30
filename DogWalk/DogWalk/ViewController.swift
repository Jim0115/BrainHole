//
//  ViewController.swift
//  DogWalk
//
//  Created by 王仕杰 on 5/27/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit
import CoreData
import SafariServices

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var addButton: UIBarButtonItem!
  
  var managedContext: NSManagedObjectContext!
  var currentDog: Dog!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let fetchRequest = NSFetchRequest(entityName: "Dog")
    fetchRequest.predicate = NSPredicate(format: "name = %@", "Fido")
    fetchRequest.fetchLimit = 10
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    deleteRequest.resultType = .ResultTypeCount
    
    do {
      let deleteResult = try managedContext.executeRequest(deleteRequest) as! NSBatchDeleteResult
      // do sth here
      print(deleteResult.result)
    } catch let error as NSError {
      print(error.localizedDescription)
    }

    //    do {
    //      let result = try managedContext.executeFetchRequest(dogFetch)
    //      if !result.isEmpty {
    //        currentDog = result[0] as! Dog
    //      } else {
    //        currentDog = NSEntityDescription.insertNewObjectForEntityForName("Dog", inManagedObjectContext: managedContext) as! Dog
    //        currentDog.name = dogName
    //        try managedContext.save()
    //      }
    //    } catch let error as NSError {
    //      print(error.localizedDescription)
    //    }
    
  }
  
  
  @IBAction func add(sender: UIBarButtonItem) {
    let vc = SFSafariViewController(URL: NSURL(string: "http://www.baidu.com")!)
    presentViewController(vc, animated: true, completion: nil)
    //    let walkEntity = NSEntityDescription.insertNewObjectForEntityForName("Walk", inManagedObjectContext: managedContext) as! Walk
    //    walkEntity.date = NSDate()
    //
    //    let walks = currentDog.walks!.mutableCopy() as! NSMutableOrderedSet
    //    walks.addObject(walkEntity)
    //    currentDog.walks = walks
    //
    //    do {
    //      try managedContext.save()
    //    } catch let error as NSError {
    //      print(error.localizedDescription)
    //    }
    //
    //    tableView.reloadData()
    //
    //    addButton.enabled = false
    //    NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(ViewController.enable), userInfo: nil, repeats: false)
  }
  
  func enable() {
    addButton.enabled = true
  }
  
  
  // MARK: - table view data source
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return currentDog.walks!.count
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("date cell", forIndexPath: indexPath)
    
//    let walk = currentDog.walks![indexPath.row] as! Walk
//    
//    let formatter = NSDateFormatter()
//    formatter.dateStyle = .MediumStyle
//    formatter.timeStyle = .ShortStyle
//    
//    cell.textLabel?.text = formatter.stringFromDate(walk.date!)
    
    return cell
  }
  
//  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//    return true
//  }
//  
//  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//    if editingStyle == .Delete {
//      managedContext.deleteObject(currentDog.walks![indexPath.row] as! Walk)
//      do {
//        try managedContext.save()
//      } catch let error as NSError {
//        print("deletion failed: \(error.localizedDescription)")
//      }
//      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//      
//    }
//  }
}

