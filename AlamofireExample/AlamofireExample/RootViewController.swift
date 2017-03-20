//
//  ViewController.swift
//  AlamofireExample
//
//  Created by 王仕杰 on 2017/3/20.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import UIKit
import Alamofire


class RootViewController: UITableViewController {
    
    private let cellIdentifier = "RootCell"
    private let segueIdentifier = "showResult"
    private let urlPrefix = "https://www.httpbin.org"
    
    private var lastResultDict = [String: Any]()
    
    let methods = ["/ip"]
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !UIApplication.shared.isNetworkActivityIndicatorVisible else { return }
        
        let url = urlPrefix + methods[indexPath.row]
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Alamofire.request(url).responseJSON { (response) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let error = response.error {
                let alert = UIAlertController(title: "Network Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Confirm", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            } else if let jsonDict = response.result.value as? Dictionary<String, Any> {
                self.lastResultDict = jsonDict
                self.performSegue(withIdentifier: self.segueIdentifier, sender: tableView.cellForRow(at: indexPath))
            } else {
                fatalError("数据解析错误")
            }
        }
    }

    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return methods.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = methods[indexPath.row]
        
        return cell
    }
    
    // MARK: - UIStoryboardSegue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == segueIdentifier else { fatalError("Cannot match segue identifier") }
        guard let destination = segue.destination as? DetailViewController else { fatalError("Error type of destination view controller") }
        
        destination.resultDicts = lastResultDict
        destination.title = "Result"
    }

}

