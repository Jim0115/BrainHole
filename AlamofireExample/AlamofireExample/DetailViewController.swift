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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultTuples.count
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = resultTuples[indexPath.row].0
        cell.detailTextLabel?.text = "\(resultTuples[indexPath.row].1)"
        
        return cell
    }
}
