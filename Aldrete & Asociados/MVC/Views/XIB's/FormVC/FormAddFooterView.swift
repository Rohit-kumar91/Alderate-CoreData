//
//  FormAddFooterView.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 28/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class FormAddFooterView: UITableViewHeaderFooterView, ReusableHeaderFooter {
  
  typealias T = FormModel

  @IBOutlet weak var btnAdd: UIButton!
  
  var item: FormModel? {
    didSet {
      
    }
  }
  
  @IBAction func btnAddAction(_ sender: Any) {
    
  }
}
