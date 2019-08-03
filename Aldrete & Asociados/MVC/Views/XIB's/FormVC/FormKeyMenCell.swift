//
//  FormKeyMenCell.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 28/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class FormKeyMenCell: UITableViewCell, ReusableCell {

  @IBOutlet var textFields: [UITextField]!
  var item: Any? {
    didSet {
      let obj = item as? FormTextField
      for (index, tf) in textFields.enumerated() {
        tf.placeholder = /obj?.fields?[index].placeHolder?.localized
      }
    }
  }
    
}
