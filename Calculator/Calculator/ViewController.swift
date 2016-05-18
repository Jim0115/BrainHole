//
//  ViewController.swift
//  Calculator
//
//  Created by 王仕杰 on 5/11/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var screen: UILabel!
  var reset = false
  var status: Arithmetic = .none
  var haveDot: Bool {
    return screen.text!.containsString(".")
  }
  var answer = 0.0 {
    didSet {
      print(answer)
    }
  }
  
  @IBAction func appendDigit(sender: UIButton) {
    if (screen.text! == "0" || reset) && sender.currentTitle != "." {
      screen.text = sender.currentTitle
      
      reset = false
    } else {
      screen.text?.appendContentsOf(sender.currentTitle!)
    }
  }
  
  @IBAction func clean(sender: UIButton) {
    screen.text = "0"
    answer = 0
    status = .none
    reset = true
  }
  
  @IBAction func dot(sender: UIButton) {
    if !haveDot {
      appendDigit(sender)
    }
  }
  
//  @IBAction func add(sender: UIButton) {
//    answer += Double(screen.text!)!
//    if answer.isDecimal {
//      screen.text = String(format: "%.0f", answer)
//    } else {
//      screen.text = answer.description
//    }
//    reset = true
//  }
  
  @IBAction func arithmetic(sender: UIButton) {
    answer = Double(screen.text!)!
    switch sender.currentTitle! {
    case "+":
      status = .add
    case "−":
      status = .subtract
    case "×":
      status = .multiply
    case "÷":
      status = .devide
    default:
      break
    }
    reset = true
  }
  
  @IBAction func equal(sender: UIButton) {
    var tmp = 0.0
    let s = Double(screen.text!)!
    switch status {
    case .add:
      tmp = answer + s
    case .subtract:
      tmp = answer - s
    case .multiply:
      tmp = answer * s
    case .devide:
      tmp = answer / s
    case .none:
      break
    }
    tmp = foo(status)(answer, s)
    screen.text = tmp.screenValue
    reset = true
    status = .none
  }
  
  func foo(ari: Arithmetic) -> (Double, Double) -> Double {
    switch ari {
    case .add:
      return { $0 + $1 }
    case .subtract:
      return { $0 - $1 }
    case .multiply:
      return { $0 * $1 }
    case .devide:
      return { $0 / $1 }
    case .none:
      return { _,_ in return Double(Int.min) }
    }
  }
  
}

enum Arithmetic {
  case add, subtract, multiply, devide, none
}

private extension Double {
  var screenValue: String {
    if round(self) - self == 0 {
      return String(format: "%.0f", self)
    } else {
      return String(format: "%.2f", self)
    }
  }
}
