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
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "teamName", ascending: true)]
    
    fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
    
    do {
      try fetchedResultController.performFetch()
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    
  }
  
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

}

