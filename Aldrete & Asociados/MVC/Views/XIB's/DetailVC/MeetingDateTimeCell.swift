//
//  MeetingDateTimeCell.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 25/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class MeetingDateTimeCell: UITableViewCell, ReusableCell {

  @IBOutlet weak var lblDate: UILabel!
  @IBOutlet weak var lblTime: UILabel!
  
  var item: Any? {
    didSet {
      
    }
  }
  
}
