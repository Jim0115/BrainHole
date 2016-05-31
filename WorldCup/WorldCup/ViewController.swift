//
//  ViewController.swift
//  WorldCup
//
//  Created by 王仕杰 on 5/30/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var addButton: UIBarButtonItem!
  @IBOutlet weak var tableView: UITableView!
  
  let coreDataStack = CoreDataStack.sharedStack
  var fetchedResultController: NSFetchedResultsController!
  
  override func viewDidLoad() {
    
    tableView.estimatedRowHeight = 100.0
    
    let fetchRequest = NSFetchRequest(entityName: "Team")
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "qualifyingZone", ascending: true), NSSortDescriptor(key: "wins", ascending: false), NSSortDescriptor(key: "teamName", ascending: true)]
    fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: "qualifyingZone", cacheName: "WorldCup")
    fetchedResultController.delegate = self
    do {
      try fetchedResultController.performFetch()
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    
  }
  
  // MARK: - table view data source
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return fetchedResultController.sections!.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchedResultController.sections![section].numberOfObjects
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("team cell", forIndexPath: indexPath) as! TeamCell
    
    let team = fetchedResultController.objectAtIndexPath(indexPath) as! Team
    cell.flagImageView.image = UIImage(named: team.imageName!)
    cell.teamLabel.text = team.teamName
    cell.scoreLabel.text = "Wins: \(team.wins!)"
    
    cell.flagImageView.layer.borderWidth = 1
    cell.flagImageView.layer.borderColor = UIColor.blackColor().CGColor
    
    return cell
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let team = fetchedResultController.sections![section]
    return team.name
  }
  
  // MARK: - table view delegate
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let team = fetchedResultController.objectAtIndexPath(indexPath) as! Team
    
    let win = team.wins!.integerValue
    team.wins = NSNumber(integer: win + 1)
    
    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    coreDataStack.saveContext()
  }
}

extension ViewController: NSFetchedResultsControllerDelegate {
  func controllerWillChangeContent(controller: NSFetchedResultsController) {
    tableView.beginUpdates()
  }
  
  func controllerDidChangeContent(controller: NSFetchedResultsController) {
    tableView.endUpdates()
  }
  
  func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    switch type {
    case .Insert:
      tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
    case .Delete:
      tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
    case .Move:
      tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
    case .Update:
      let cell = tableView.cellForRowAtIndexPath(indexPath!) as! TeamCell
      let team = controller.objectAtIndexPath(indexPath!) as! Team
      cell.flagImageView.image = UIImage(named: team.imageName!)
      cell.teamLabel.text = team.teamName
      cell.scoreLabel.text = "Wins: \(team.wins!)"
      
      cell.flagImageView.layer.borderWidth = 1
      cell.flagImageView.layer.borderColor = UIColor.blackColor().CGColor
    }
  }
  
  func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
    
    let indexSet = NSIndexSet(index: sectionIndex)
    
    switch type {
    case .Insert:
      tableView.insertSections(indexSet, withRowAnimation: .Automatic)
    case .Delete:
      tableView.deleteSections(indexSet, withRowAnimation: .Automatic)
    default:
      break
    }
  }
}