//
//  MasterSection.swift
//  Aldrete & Asociados
//
//  Created by Sandeep Kumar on 24/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class MasterSection: UITableViewHeaderFooterView, ReusableHeaderFooter {
  
  typealias T = MasterContactsModel
  
  @IBOutlet weak var backView: UIView!
  @IBOutlet weak var lblTitle: UILabel!
  
  var item: MasterContactsModel? {
    didSet {
      lblTitle.text = /item?.other?.title
    }
  }
  
}
