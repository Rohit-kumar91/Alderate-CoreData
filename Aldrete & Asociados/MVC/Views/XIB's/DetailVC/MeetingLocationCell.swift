//
//  MeetingLocationCell.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 25/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class MeetingLocationCell: UITableViewCell, ReusableCell {
  
  @IBOutlet weak var imgView: UIImageView!
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblSubtitle: UILabel!
  @IBOutlet weak var btnCancel: UIButton!
  
  var item: Any? {
    didSet {
      
    }
  }
  
  @IBAction func btnCancelAction(_ sender: UIButton) {
    
  }
}
