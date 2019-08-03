//
//  UserInformationCell.swift
//  Aldrete & Asociados
//
//  Created by NewMacMini1 on 08/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class UserInformationCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    
    var didTapAdd: ((UIButton) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func moreOptionAction(_ sender: UIButton) {
         didTapAdd?(sender)
    }
}
