//
//  ContactCell.swift
//  Aldrete & Asociados
//
//  Created by NewMacMini1 on 03/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class ContactDetailCell: UITableViewCell {
    
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var contactType: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
