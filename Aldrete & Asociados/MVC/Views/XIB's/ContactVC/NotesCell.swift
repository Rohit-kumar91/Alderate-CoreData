//
//  NotesCell.swift
//  Aldrete & Asociados
//
//  Created by NewMacMini1 on 11/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    var notesData = String()
    
    var didNotesTapAdd: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textView.delegate = self
        if textView.text == "" {
            editButton.setTitle("Add", for: .normal)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editButtonAction(_ sender: UIButton) {
        if sender.currentTitle == "Done" {
            textView.endEditing(true)
            didNotesTapAdd?()
        } else {
            textView.isEditable = true
            textView.becomeFirstResponder()
        }
    }
}

extension NotesCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        editButton.setTitle("Done", for: .normal)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        notesData = textView.text
        editButton.setTitle("Edit", for: .normal)
    }
    
}
