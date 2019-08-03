//
//  FilterCell.swift
//  Aldrete & Asociados
//
//  Created by Sandeep Kumar on 24/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var textFld: UITextField!
    
    var didTapAdd: ((_ item: UIButton) -> Void)?
    var selectDate: ((_ item: UITextField) -> Void)?
    
    var item: Any? {
        didSet {
            let filter = item as? Filter
            lblTitle.text = /filter?.name
            
            if lblTitle.text == "Date" {
                textFld.isHidden = false
            }else {
                textFld.isHidden = true
            }
            
            imgView.image = filter?.image
        }
    }
    
    
    @IBAction func MoreButtonAction(_ sender: UIButton) {
        
        if sender.tag == 0 {
            didTapAdd?(sender)
        }
        
    }
}
extension FilterCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         textField.autocorrectionType = .no
           selectDate?(textField)
    
    }
    
    
}
