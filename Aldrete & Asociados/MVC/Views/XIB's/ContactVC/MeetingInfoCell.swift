//
//  MeetingInfoCell.swift
//  Aldrete & Asociados
//
//  Created by Rohit Prajapati on 09/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class MeetingInfoCell: UITableViewCell {

    @IBOutlet weak var meetingWithLbl: UILabel!
    @IBOutlet weak var meetingLabel: UILabel!
    @IBOutlet weak var meetingDate: UILabel!
    @IBOutlet weak var meetingLocation: UILabel!
    @IBOutlet weak var meetingTime: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var presentationImage: UIImageView!
    @IBOutlet weak var presentationName: UILabel!
    @IBOutlet weak var NameStackview: UIStackView!
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    @IBOutlet weak var btnMore: UIButton!
    
    
    var didTapDeleteMeeting: ((UIButton) -> Void)?
    var didTapMoreAction: ((UIButton) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteMeetingAction(_ sender: UIButton) {
        didTapDeleteMeeting?(sender)
    }
    
//    @IBAction func btnMoreData(_ sender: UIButton) {
//        didTapMoreAction?(sender)
//    }
    
    @IBAction func btnDataMore(_ sender: UIButton) {
        
         didTapMoreAction?(sender)
    }
}
