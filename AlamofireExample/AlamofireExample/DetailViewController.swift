//
//  DetailViewController.swift
//  AlamofireExample
//
//  Created by 王仕杰 on 2017/3/20.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    var resultDicts = [String: Any]()
    private lazy var resultTuples: [(String, Any)] = {
        var tuples = [(String, Any)]()
        for (k, v) in self.resultDicts {
            tuples.append((k, v))
        }
        
        tuples.sort { $0.0 < $1.0 }
        return tuples
    }()
    
    private let cellIdentifier = "resultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(resultDicts)
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultTuples.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let (key, result) = resultTuples[indexPath.row]
        
        cell.textLabel?.text = key
        cell.detailTextLabel?.text = "\(result)"
        let hasMoreDetail = result is Array<Any> || result is Dictionary<String, Any>
        cell.selectionStyle = hasMoreDetail ? .default : .none
        cell.accessoryType = hasMoreDetail ? .disclosureIndicator : .none
        
        return cell
    }
    
    // MARK: - UIStoryBoardSegue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let cell = sender as? UITableViewCell else { return false }
        return cell.selectionStyle != .none
    }

    
}
