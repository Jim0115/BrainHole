//
//  TeaTVC.swift
//  BubbleTeaFinder
//
//  Created by 王仕杰 on 5/28/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit
import CoreData

class TeaTVC: UITableViewController {
  
  var coredataStack: CoreDataStack!
  var fetchRequest: NSFetchRequest!
  var venues: [Venue]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //    let url = NSBundle.mainBundle().URLForResource("seed", withExtension: "json")
    //    let s = try! String(contentsOfURL: url!, encoding: NSUTF8StringEncoding)
    //    print(s)
    
    //    let model = coredataStack.managedContext.persistentStoreCoordinator?.managedObjectModel
//    let model = coredataStack.coordinator.managedObjectModel
    
//    fetchRequest = model.fetchRequestTemplateForName("FetchRequest")
    
    fetchRequest = NSFetchRequest(entityName: "Venue")
    
    //    venues = try! coredataStack.managedContext.executeFetchRequest(fetchRequest) as! [Venue]
    
    fetchAndReload()
  }
  
  func fetchAndReload() {
    do {
      venues = try coredataStack.managedContext.executeFetchRequest(fetchRequest) as! [Venue]
      tableView.reloadData()
    } catch let error as NSError {
      print("fetch error: " + error.localizedDescription)
    }
    tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Top, animated: false)
  }
  
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return venues.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("tea cell", forIndexPath: indexPath)
    
    let venue = venues[indexPath.row]
    
    cell.textLabel?.text = venue.name
    cell.detailTextLabel?.text = venue.priceInfo?.priceCategory
    
    return cell
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "filter" {
      let navi = segue.destinationViewController as! UINavigationController
      let filterVC = navi.topViewController as! FilterTVC
      
      filterVC.coredataStack = coredataStack
      filterVC.delegate = self
    }
  }
  
  
}

extension TeaTVC: FilterVCDelegate {
  func filterViewController(filter: FilterTVC, didSelectedPredicate predicate: NSPredicate?, sortDescriptor: NSSortDescriptor?) {
    fetchRequest.predicate = nil
    fetchRequest.sortDescriptors = nil
    
    fetchRequest.predicate = predicate
    fetchRequest.sortDescriptors = sortDescriptor == nil ? nil : [sortDescriptor!]
    
    fetchAndReload()
  }
}
