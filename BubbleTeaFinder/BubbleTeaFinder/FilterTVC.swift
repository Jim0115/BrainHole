//
//  FilterTVC.swift
//  BubbleTeaFinder
//
//  Created by 王仕杰 on 5/28/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit
import CoreData

class FilterTVC: UITableViewController {
  
  @IBOutlet weak var firstPriceCategoryLabel: UILabel!
  @IBOutlet weak var secondPriceCategoryLabel: UILabel!
  @IBOutlet weak var thirdPriceCategoryLabel: UILabel!
  @IBOutlet weak var numDealsLabel: UILabel!
  
  var coredataStack: CoreDataStack!
  
  weak var delegate: FilterVCDelegate?
  var selectedSortDescriptor: NSSortDescriptor?
  var selectedPredicate: NSPredicate?
  
  lazy var cheapVenuePredicate: NSPredicate = {
    NSPredicate(format: "priceInfo.priceCategory = %@", "$")
  }()
  
  lazy var moderateVenuePredicate: NSPredicate = {
    NSPredicate(format: "priceInfo.priceCategory = %@", "$$")
  }()
  
  lazy var expensiveVenuePredicate: NSPredicate = {
    NSPredicate(format: "priceInfo.priceCategory = %@", "$$$")
  }()
  
  let offeringDealPredicate = NSPredicate(format: "specialCount > 0")
  let walkingDistancePredicate = NSPredicate(format: "location.distance < 1000")
  let hasUserTipsPredicate = NSPredicate(format: "stats.tipCount > 0")
  
  let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
  let distanceSortDescriptor = NSSortDescriptor(key: "location.distance", ascending: true)
  let priceSortDescriptor = NSSortDescriptor(key: "priceInfo.priceCategory", ascending: true)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    populateCheapVenueCountLabel()
    moderateCheapVenueCountLabel()
    expensiveCheapVenueCountLabel()
    populataDealsCountLabel()
  }
  
  func populateCheapVenueCountLabel() {
    let fetchRequest = NSFetchRequest(entityName: "Venue")
    fetchRequest.predicate = cheapVenuePredicate
    fetchRequest.resultType = .CountResultType
    
    do {
      let result = try coredataStack.managedContext.executeFetchRequest(fetchRequest) as! [NSNumber]
      firstPriceCategoryLabel.text = "\(result.first!.integerValue) bubble tea places"
    } catch let error as NSError {
      print(error.localizedDescription)
    }
  }
  
  func moderateCheapVenueCountLabel() {
    let fetchRequest = NSFetchRequest(entityName: "Venue")
    fetchRequest.predicate = moderateVenuePredicate
    fetchRequest.resultType = .CountResultType
    
    do {
      let result = try coredataStack.managedContext.executeFetchRequest(fetchRequest) as! [NSNumber]
      secondPriceCategoryLabel.text = "\(result.first!.integerValue) bubble tea places"
    } catch let error as NSError {
      print(error.localizedDescription)
    }
  }
  
  func expensiveCheapVenueCountLabel() {
    let fetchRequest = NSFetchRequest(entityName: "Venue")
    fetchRequest.predicate = expensiveVenuePredicate
    
    var e: NSError?
    let result = coredataStack.managedContext.countForFetchRequest(fetchRequest, error: &e)
    if e == nil {
      thirdPriceCategoryLabel.text = "\(result) bubble tea places"
    } else {
      print(e!.localizedDescription)
    }
  }
  // to do
  func populataDealsCountLabel() {
    let fetchRequest = NSFetchRequest(entityName: "Venue")
    fetchRequest.resultType = .DictionaryResultType
    
    let sumExpressionDesc = NSExpressionDescription()
    sumExpressionDesc.name = "sumDeals"
    
    sumExpressionDesc.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "specialCount")])
    sumExpressionDesc.expressionResultType = .Integer32AttributeType
    
    fetchRequest.propertiesToFetch = [sumExpressionDesc]
    
    do {
      let result = try coredataStack.managedContext.executeFetchRequest(fetchRequest) as! [NSDictionary]
      //      print(result.reduce(0) { $0 + ($1["specialCount"] as! Int) })
      let resultDict = result.first!
      let numDeals = resultDict["sumDeals"]!
      numDealsLabel.text = "\(numDeals) total deals"
    } catch let error as NSError {
      print(error.localizedDescription)
    }
  }
  
  @IBAction func cancel(sender: UIBarButtonItem) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  
  @IBAction func search(sender: UIBarButtonItem) {
    delegate?.filterViewController(self, didSelectedPredicate: selectedPredicate, sortDescriptor: selectedSortDescriptor)
    cancel(sender)
  }
  
  // table view delegate
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.section == 2 {
      tableView.visibleCells.filter { tableView.indexPathForCell($0)!.section == 2 }.forEach { $0.accessoryType = .None }
    } else {
      tableView.visibleCells.filter { tableView.indexPathForCell($0)!.section != 2 }.forEach { $0.accessoryType = .None }
    }
    switch (indexPath.section, indexPath.row) {
    case (0, 0):
      selectedPredicate = cheapVenuePredicate
    case (0, 1):
      selectedPredicate = moderateVenuePredicate
    case (0, 2):
      selectedPredicate = expensiveVenuePredicate
    case (1, 0):
      selectedPredicate = offeringDealPredicate
    case (1, 1):
      selectedPredicate = walkingDistancePredicate
    case (1, 2):
      selectedPredicate = hasUserTipsPredicate
    case (2, 0):
      selectedSortDescriptor = nameSortDescriptor
    case (2, 1):
      selectedSortDescriptor = nameSortDescriptor.reversedSortDescriptor as? NSSortDescriptor
    case (2, 2):
      selectedSortDescriptor = distanceSortDescriptor
    case (2, 3):
      selectedSortDescriptor = priceSortDescriptor
    default:
      print("default")
    }
    tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
  }
  
}

protocol FilterVCDelegate: class {
  func filterViewController(filter: FilterTVC, didSelectedPredicate predicate: NSPredicate?, sortDescriptor: NSSortDescriptor?)
}
