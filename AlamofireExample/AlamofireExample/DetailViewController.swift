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
    private let segueIdentifier = "showDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(resultDicts)
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.cellForRow(at: indexPath)!.accessoryType == .none else { return }
        let (key, result) = resultTuples[indexPath.row]
        
        let alert = UIAlertController(title: "", message: "\(key) : \(result)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .cancel, handler: { _ in tableView.deselectRow(at: indexPath, animated: true) } ))
        present(alert, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultTuples.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let (key, result) = resultTuples[indexPath.row]
        
        cell.textLabel?.text = key
        
        let hasMoreDetail = result is Array<Any> || result is Dictionary<String, Any>
        
        cell.detailTextLabel?.text = hasMoreDetail ? "" : "\(result)"
        cell.accessoryType = hasMoreDetail ? .disclosureIndicator : .none
        
        return cell
    }
    
    // MARK: - UIStoryBoardSegue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let cell = sender as? UITableViewCell else { return false }
        return cell.accessoryType != .none
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == segueIdentifier else { fatalError("Wrong segue identifier") }
        guard let destination = segue.destination as? DetailViewController else { fatalError("Error destination type") }
        
        destination.resultDicts = resultTuples[tableView.indexPath(for: sender as! UITableViewCell)!.row].1 as! Dictionary<String, Any>
    }
}
