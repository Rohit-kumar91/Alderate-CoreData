//
//  KeyMenChildDependentSectionView.swift
//  Aldrete & Asociados
//
//  Created by NewMacMini1 on 01/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class KeyMenChildDependentSectionView: UITableViewHeaderFooterView, ReusableHeaderFooter {
    
    typealias T = FormModel

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var btnAdd: UIButton!
    
    var myPickerView : UIPickerView!
    var pickerData = ["Yes" , "No"]
    var datePicker:UIDatePicker!
    var didTapAdd: ((_ item: FormModel?) -> Void)?
    
    var item: FormModel? {
        didSet {
            
            textFields.forEach {
                $0.delegate = self
            }
            
            lblTitle.text = /item?.other?.title
            textFields[0].placeholder = VCLiteral.CF_SEC_CONTACT_INFO_F1.localized
            textFields[1].placeholder = VCLiteral.CF_SEC_PERSONAL_INFO_F1.localized
            textFields[2].placeholder = VCLiteral.CF_SEC_KEY_MEN_F3.localized
            textFields[3].placeholder = VCLiteral.CF_SEC_KEY_MEN_F4.localized
            textFields[4].placeholder = VCLiteral.CF_SEC_KEY_MEN_F5.localized
            textFields[5].placeholder = VCLiteral.CF_SEC_KEY_MEN_F6.localized
            
            textFields[0].text = /(item?.tf1Value as? String)
            textFields[1].text = /(item?.tf2Value as? String)
            textFields[2].text = /(item?.tf3Value as? String)
            textFields[3].text = /(item?.tf4Value as? String)
            textFields[4].text = /(item?.tf5Value as? String)
            textFields[5].text = /(item?.tf6Value as? String)

            
            btnAdd.setTitle(VCLiteral.CF_SEC_KEY_MEN_BTN_ADD.localized, for: .normal)
        }
    }
    
    @IBAction func addDependient(_ sender: UIButton) {
        didTapAdd?(item)
    }
    
    
}

extension KeyMenChildDependentSectionView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if textField == textFields[3] {
            textField.autocorrectionType = .no
            pickerView(textField)
        }else if textField == textFields[2] {
            textField.keyboardType = .numberPad
        } else if textField == textFields[4] {
            textField.keyboardType = .numberPad
        } else if textField == textFields[5] {
            textField.keyboardType = .numberPad
        } else if textField == textFields[1] {
            textField.autocorrectionType = .no
            setDateValue(textfield: textField)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.textInputMode?.primaryLanguage == "emoji") || !((textField.textInputMode?.primaryLanguage) != nil) {
            return false
        } else if textField.placeholder == VCLiteral.CF_SEC_KEY_MEN_F3.localized {
            let maxLength = 3
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            (item)?.tf3Value = newString
            return newString.length <= maxLength
        }
        
        var str:NSString = textField.text! as NSString
        str = str.replacingCharacters(in: range, with: string) as NSString
        

        if textField.placeholder == VCLiteral.CF_SEC_CONTACT_INFO_F1.localized {
            print("1")
            (item)?.tf1Value = str
        }
        
        
        if textField.placeholder == VCLiteral.CF_SEC_PERSONAL_INFO_F1.localized {
            print("2")
            (item)?.tf2Value = str
        }
        
//        if textField.placeholder == VCLiteral.CF_SEC_KEY_MEN_F3.localized {
//            print("3")
//            (item)?.tf3Value = str
//        }
        
        if textField.placeholder == VCLiteral.CF_SEC_KEY_MEN_F4.localized {
            (item)?.tf4Value = str
        }
        
        if textField.placeholder == VCLiteral.CF_SEC_KEY_MEN_F5.localized {
            (item)?.tf5Value = str
        }
        
        if textField.placeholder == VCLiteral.CF_SEC_KEY_MEN_F6.localized {
            (item)?.tf6Value = str
        }
        
        return true
    }
    
    
    func setDateValue(textfield: UITextField) {
        
        let customView:UIView = UIView (frame: CGRect(x: 0, y: 100, width: 320, height: 160))
        customView.backgroundColor = .white
        datePicker = UIDatePicker(frame: CGRect(x: (self.contentView.bounds.size.width / 2) - 160, y: 0, width: 320, height: 160))
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        customView.addSubview(datePicker)
        textfield.inputView = customView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = Colors.APP_THEME.uiColor
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(datePickerSelected))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textfield.inputAccessoryView = toolBar
    }
    
    @objc func datePickerSelected() {
        
        (item)?.tf2Value =  datePicker.date.string(format: "dd/MM/yyyy")
        textFields[1].text = datePicker.date.string(format: "dd/MM/yyyy")
        textFields[1].resignFirstResponder()
        
    }
}

extension KeyMenChildDependentSectionView {
    
    func pickerView(_ textField : UITextField){
        
        // UIPickerView
        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: 216))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        textField.inputView = self.myPickerView
        
        //set the picker
        if textField.text == "No" {
            myPickerView.selectRow(1, inComponent: 0, animated: false)
        } else {
            myPickerView.selectRow(0, inComponent: 0, animated: false)
        }
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = Colors.APP_THEME.uiColor
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(FormCell.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(FormCell.cancelClick))
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    
    @objc func doneClick() {
        if ((item)?.tf4Value as? String) == nil {
            textFields[3].text = "Yes"
            (item)?.tf4Value = "Yes"
        }
        
        textFields[3].resignFirstResponder()
    }
    @objc func cancelClick() {
        textFields[3].resignFirstResponder()
    }
    
}

extension KeyMenChildDependentSectionView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //self.txt_pickUpData.text = pickerData[row]
        (item)?.tf4Value = pickerData[row]
        textFields[3].text = pickerData[row]
    }
}
