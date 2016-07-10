//
//  QSZhihuRandomHelper.swift
//  QuickStart
//
//  Created by 王仕杰 on 7/10/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class QSZhihuRandomHelper: NSObject {
  
  class func randomAddress(completeHandler: (NSURL) -> Void) {
    let rex = try! NSRegularExpression(pattern: "https://www.zhihu.com/question/\\d{8}", options: .CaseInsensitive)

    let url = NSURL(string: "https://www.zhihu.com/explore")!
    
    let session = NSURLSession.sharedSession()
    
    let task = session.dataTaskWithURL(url) { (data, _, error) in
      if let error = error {
        print(error)
      } else {
        if let data = data {
          let result = NSString(data: data, encoding: NSUTF8StringEncoding)!
          let results = rex.matchesInString(result as String, options: [], range: NSRange(location: 0, length: result.length))
          let range = results.randomElement().range
          let str = result.substringWithRange(range)
          let url = "zhihu://questions/\(str.componentsSeparatedByString("/").last!)"
          completeHandler(NSURL(string: url)!)
        }
      }
    }
    task.resume()
  }
}

extension Array {
  func randomElement() -> Element {
    return self[0 + Int(arc4random_uniform(UInt32(self.count)))]
  }
}