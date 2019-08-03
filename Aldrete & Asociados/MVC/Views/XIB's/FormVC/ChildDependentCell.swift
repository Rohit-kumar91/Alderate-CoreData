//
//  ChildDependentCell.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 01/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class ChildDependentCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    var didTapDelete: (() -> Void)?
    
    var item: Any? {
        didSet {
            let formObj = (item as? FormTextField)?.fields
            lblName.text = /(formObj?[0].value as? String)
            ///formObj?.fields?.first?.placeHolder?.localized //Replace with value
            lblDob.text = /(formObj?[1].value as? String)
            ///formObj?.fields?.last?.placeHolder?.localized
        }
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton) {
        didTapDelete?()
    }
}
