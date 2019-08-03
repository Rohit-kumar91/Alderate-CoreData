//
//  FormSectionView.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 28/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class FormSectionView: UITableViewHeaderFooterView, ReusableHeaderFooter {
    
    
    typealias T = FormModel
    
  
//  typealias T = FormModel
  
  @IBOutlet weak var lblTitle: UILabel!
  
  var item: FormModel? {
    didSet {
      lblTitle.text = /item?.other?.title
    }
  }
  
}
