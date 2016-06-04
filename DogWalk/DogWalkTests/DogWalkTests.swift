//
//  DogWalkTests.swift
//  DogWalkTests
//
//  Created by 王仕杰 on 6/1/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import XCTest

class DogWalkTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() {
    var array = [Int]()
    for i in 0...10000 { array.append(i) }
    let set = Set(array)
    self.measureBlock {
      print(set.contains(20000))
    }
  }
  
}
