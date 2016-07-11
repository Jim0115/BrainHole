//
//  TodayViewController.swift
//  QuickStartCenter
//
//  Created by 王仕杰 on 7/8/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UICollectionViewDataSource, UICollectionViewDelegate {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  
  lazy var urls: [String] = {
    return ["alipayqr://platformapi/startapp?saId=20000056", "alipayqr://platformapi/startapp?saId=10000014", "weixin://dl/moments", "weixin://dl/scan", "", "sms:763240186@qq.com"]
//    return strings.map { NSURL(string: $0)! }
  }()
  
  lazy var images: [String] = {
    var images = [String]()
    
    let path = NSBundle.mainBundle().resourcePath!
    let items = try! NSFileManager.defaultManager().contentsOfDirectoryAtPath(path)
    
    for item in items {
      if item.hasSuffix("png") {
        images.append(item)
      }
    }
    
    return images
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(images)
    preferredContentSize = CGSize(width: 0, height: 200)
  }
  
  func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
    completionHandler(NCUpdateResult.NewData)
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count // urls.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("reuse cell", forIndexPath: indexPath) as! ImageCell
    
    cell.imageView.image = UIImage(named: images[indexPath.row])
    cell.titleLabel.text = images[indexPath.row].componentsSeparatedByString(".")[1]
    
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    if indexPath.row == 4 {
      QSZhihuRandomHelper.randomAddress { [weak self] (url) in
        self?.extensionContext?.openURL(url, completionHandler: nil)
      }
    } else {
      extensionContext?.openURL(NSURL(string: urls[indexPath.row])!, completionHandler: nil)
    }
  }
  
}
