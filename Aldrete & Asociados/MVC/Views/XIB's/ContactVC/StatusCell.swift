//
//  StatusCell.swift
//  Aldrete & Asociados
//
//  Created by NewMacMini1 on 08/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {

    var myPickerView : UIPickerView!
    var statusValue = String()
    var didStatusChange: (() -> Void)?
    
    @IBOutlet weak var statusTextfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        statusTextfield.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func pickerView(_ textField : UITextField){
        
        // UIPickerView
        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: 216))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        textField.inputView = self.myPickerView
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = Colors.APP_THEME.uiColor
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(FormCell.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    @objc func doneClick() {
        self.endEditing(true)
    }
    
    
    
}

extension StatusCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.autocorrectionType = .no
        statusTextfield.text = VCLiteral.statusVAlues[0].localized
        statusValue = VCLiteral.statusVAlues[0].localized
        didStatusChange?()
        pickerView(textField)
        
    }
}

extension StatusCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return VCLiteral.statusVAlues.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return VCLiteral.statusVAlues[row].localized
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       statusTextfield.text = VCLiteral.statusVAlues[row].localized
        statusValue = VCLiteral.statusVAlues[row].localized
        didStatusChange?()
    }
        
}




