//
//  TeamCell.swift
//  WorldCup
//
//  Created by 王仕杰 on 5/30/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {
  
  @IBOutlet weak var teamLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var flagImageView: UIImageView!
  
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    teamLabel.text = nil
    scoreLabel.text = nil
    flagImageView.image = nil
    
  }
}
