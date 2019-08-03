//
//  DetailSection.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 25/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class DetailSection: UITableViewHeaderFooterView, ReusableHeaderFooter {
  
  typealias T = DetailSectionModel

  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var btnEdit: UIButton!
  
  var item: DetailSectionModel? {
    didSet {
      
    }
  }

  
  @IBAction func btnEditAction(_ sender: UIButton) {
    
  }
}
