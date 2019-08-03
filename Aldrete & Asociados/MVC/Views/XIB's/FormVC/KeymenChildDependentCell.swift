//
//  KeymenChildDependentCell.swift
//  Aldrete & Asociados
//
//  Created by NewMacMini1 on 02/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class KeymenChildDependentCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var didTapDelete: (() -> Void)?
    
    var item: Any? {
        didSet {
            let formObj = (item as? FormTextField)?.fields
            lbl1.text = /(formObj?[0].value as? String)
            lbl2.text = /(formObj?[1].value as? String)
            lbl3.text = /(formObj?[2].value as? String)
            lbl4.text = /(formObj?[3].value as? String)
            lbl5.text = /(formObj?[4].value as? String)
            lbl6.text = /(formObj?[5].value as? String)
        }
    }
    
    @IBAction func deletButtonAction(_ sender: Any) {
      didTapDelete?()
    }
    
}
