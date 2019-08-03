//
//  ContactCell.swift
//  Aldrete & Asociados
//
//  Created by Sandeep Kumar on 24/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell, ReusableCell {
  
  @IBOutlet weak var lblName: UILabel!
  
  var item: Any? {
    didSet {
      let company = item as? ProfileFullData
      lblName.attributedText = (/company?.contactInfo?.fullName).getAttributedName()
    }
  }
  
    
}


