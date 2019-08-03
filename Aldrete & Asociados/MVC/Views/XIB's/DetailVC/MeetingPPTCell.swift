//
//  MeetingPPTCell.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 25/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class MeetingPPTCell: UITableViewCell, ReusableCell {

  @IBOutlet weak var lblTilte: UILabel!
  @IBOutlet weak var lblPPTName: UILabel!
  @IBOutlet weak var imgView: UIImageView!
  
  var item: Any? {
    didSet {
      
    }
  }
  
}
