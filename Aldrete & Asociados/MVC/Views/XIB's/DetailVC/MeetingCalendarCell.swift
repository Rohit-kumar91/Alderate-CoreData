//
//  MeetingCalendarCell.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 25/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class MeetingCalendarCell: UITableViewCell, ReusableCell {

  @IBOutlet weak var lblCalendar: UILabel!
  @IBOutlet weak var lblConference: UILabel!
  @IBOutlet weak var imgDot: UIImageView!
  
  var item: Any? {
    didSet {
      
    }
  }
}
