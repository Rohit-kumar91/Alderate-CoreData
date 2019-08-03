//
//  FormCell.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 28/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

extension UIKeyboardType {
    func getCapitalization() -> UITextAutocapitalizationType {
        switch self {
        case .default:
            return .sentences
        case .emailAddress:
            return .none
        case .namePhonePad:
            return .words
        default:
            return .sentences
        }
    }
}

class FormCell: UITableViewCell, ReusableCell {
  
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet var stackSubViews: [UIView]! // Tags 0 1 2
  @IBOutlet var textFields: [UITextField]! // Tags 0 1 2
  @IBOutlet var underlines: [UIView]! // Tags 0 1 2
   
  var myPickerView : UIPickerView!
  var pickerData = ["Yes" , "No"]
  var pickerSecondData = ["5", "10", "15", "de por vida"]
  var pickerFirstArraySelection = true
  var datePicker:UIDatePicker!
  var textfieldTagValue = Int()
  var item: Any? {
    
    didSet {
        
      let formObj = item as? FormTextField
        textFields.forEach {
            $0.delegate = self
        }
        
      switch /formObj?.noOfFields {
      case 3:
        stackSubViews.forEach { $0.isHidden = false }
        textFields.forEach { $0.isHidden = false }
        underlines.forEach { $0.isHidden = false }
      case 2:
        if /formObj?.isEquallyDistributed {
          stackSubViews.last?.isHidden = true
          textFields.last?.isHidden = true
          underlines.last?.isHidden = true
        } else {
          stackSubViews.last?.isHidden = false
          textFields.last?.isHidden = true
          underlines.last?.isHidden = true
        }
        textFields.first?.isHidden = false
        textFields[1].isHidden = false
        stackSubViews.first?.isHidden = false
        stackSubViews[1].isHidden = false
        underlines.first?.isHidden = false
        underlines[1].isHidden = false
      case 1:
        if /formObj?.isEquallyDistributed {
          stackSubViews.first(where: {$0.tag == 2})?.isHidden = true
          stackSubViews.first(where: {$0.tag == 1})?.isHidden = true
        } else {
          stackSubViews.first(where: {$0.tag == 2})?.isHidden = false
          stackSubViews.first(where: {$0.tag == 1})?.isHidden = false
          textFields.first(where: {$0.tag == 2})?.isHidden = true
          underlines.first(where: {$0.tag == 2})?.isHidden = true
          textFields.first(where: {$0.tag == 1})?.isHidden = true
          underlines.first(where: {$0.tag == 1})?.isHidden = true
        }
      default: break
      }
      
      for (index, tf) in (formObj?.fields ?? []).enumerated() {
        print(/tf.placeHolder?.localized)
        textFields[index].placeholder = /tf.placeHolder?.localized
        print(index)
        
        if index == 26 {
            print("sdkjfkhjkhkjghjfhjgjk")
        }
        
        print(/(tf.value as? String))
        textFields[index].text = /(tf.value as? String)
        textFields[index].keyboardType = tf.keyboardType ?? .default
        textFields[index].autocapitalizationType = (tf.keyboardType ?? .default).getCapitalization()
      }
    }
  }

}



extension FormCell: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textfieldTagValue = textField.tag
        
        if  (item as? FormTextField)?.fields?[textField.tag].placeHolder  == VCLiteral.CF_SEC_PERSONAL_INFO_F1 {
            textField.autocorrectionType = .no
            self.pickerFirstArraySelection = true
            setDateValue(textfield: textField)
        } else if (item as? FormTextField)?.fields?[textField.tag].placeHolder  == VCLiteral.CF_SEC_DATE_OF_MEETING_F1 {
            textField.autocorrectionType = .no
            self.pickerFirstArraySelection = true
            setDateValue(textfield: textField)
        } else if (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.CF_SEC_PERSONAL_INFO_F2 {
            textField.autocorrectionType = .no
            self.pickerFirstArraySelection = true
            self.pickerView(textField)
        } else if  (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.PF_SECTION_PERSONAL_INFORMATION_F1 {
            textField.autocorrectionType = .no
            self.pickerFirstArraySelection = true
            setDateValue(textfield: textField)
        } else if  (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.PF_SECTION_PERSONAL_INFORMATION_F2 {
            textField.autocorrectionType = .no
            self.pickerFirstArraySelection = true
            self.pickerView(textField)
        } else if  (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F05 {
             textField.autocorrectionType = .no
            self.pickerFirstArraySelection = true
            self.pickerView(textField)
        } else if  (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F08 {
             textField.autocorrectionType = .no
            self.pickerFirstArraySelection = true
            self.pickerView(textField)
        } else if  (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F09 {
             textField.autocorrectionType = .no
            self.pickerFirstArraySelection = true
            self.pickerView(textField)
        } else if  (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F13 {
             textField.autocorrectionType = .no
            self.pickerFirstArraySelection = true
            self.pickerView(textField)
        } else if  (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F17 {
             textField.autocorrectionType = .no
            self.pickerFirstArraySelection = true
            self.pickerView(textField)
        } else if  (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F19 {
            textField.autocorrectionType = .no
            self.pickerFirstArraySelection = true
            self.pickerView(textField)
        } else if (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F22  {
            textField.autocorrectionType = .no
            setDateValue(textfield: textField)
        } else if (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F23  {
            textField.autocorrectionType = .no
            self.pickerFirstArraySelection = false
            self.pickerView(textField)
        } else if (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F24  {
            textField.autocorrectionType = .no
            self.pickerFirstArraySelection = true
            self.pickerView(textField)
        }
        else if (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F25  {
            textField.autocorrectionType = .no
            self.pickerFirstArraySelection = true
            self.pickerView(textField)
        }
        else if (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F26  {
            textField.autocorrectionType = .no
            self.pickerFirstArraySelection = true
            self.pickerView(textField)
        }
        else if (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F27  {
            textField.autocorrectionType = .no
            self.pickerSecondData = ["5", "10", "15", "20", "de por vida"]
            self.pickerFirstArraySelection = false
            self.pickerView(textField)
        }
        else if (item as? FormTextField)?.fields?[textField.tag].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F29  {
            textField.autocorrectionType = .no
            self.pickerData = [VCLiteral.CF_PROTECTION_ONLY.localized,VCLiteral.CF_SAVING_FUND.localized]
            self.pickerFirstArraySelection = true
            self.pickerView(textField)
        }
        
        else {
            textField.inputView = nil
            textField.inputAccessoryView = nil
        }
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.textInputMode?.primaryLanguage == "emoji") || !((textField.textInputMode?.primaryLanguage) != nil) {
            return false
        }
        
        var str:NSString = textField.text! as NSString
        str = str.replacingCharacters(in: range, with: string) as NSString
        (item as? FormTextField)?.fields?[textField.tag].value = str
        return true
    }
    
    
    //MARK: DatePicker
    func setDateValue(textfield: UITextField) {
        
        let customView:UIView = UIView (frame: CGRect(x: 0, y: 100, width: 320, height: 160))
        customView.backgroundColor = .white
        datePicker = UIDatePicker(frame: CGRect(x: (self.contentView.bounds.size.width / 2) - 160, y: 0, width: 320, height: 160))
        datePicker.datePickerMode = .date
        
        if (item as? FormTextField)?.fields?[textfield.tag].placeHolder  == VCLiteral.CF_SEC_DATE_OF_MEETING_F1 {
            datePicker.minimumDate = Date()
        }
        else if (item as? FormTextField)?.fields?[textfield.tag].placeHolder  == VCLiteral.PF_SECTION_FINANCIAL_DATA_F22 {
            datePicker.minimumDate = Date()
        }
        else {
            datePicker.maximumDate = Date()
        }
        
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
        if  (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.CF_SEC_PERSONAL_INFO_F1 {
            (item as? FormTextField)?.fields?[textfieldTagValue].value =  datePicker.date.string(format: "dd/MM/yyyy")
        } else if  (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_PERSONAL_INFORMATION_F1 {
            (item as? FormTextField)?.fields?[textfieldTagValue].value =  datePicker.date.string(format: "dd/MM/yyyy")
        } else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder  == VCLiteral.CF_SEC_DATE_OF_MEETING_F1 {
            (item as? FormTextField)?.fields?[textfieldTagValue].value =  datePicker.date.string(format: "dd/MM/yyyy")
        } else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder  == VCLiteral.PF_SECTION_FINANCIAL_DATA_F22 {
            (item as? FormTextField)?.fields?[textfieldTagValue].value =  datePicker.date.string(format: "dd/MM/yyyy")
        }
        (UIApplication.topVC() as? FormVC)?.tableView.reloadData()
        self.contentView.endEditing(true)
    }
}

extension FormCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerFirstArraySelection ? pickerData.count : pickerSecondData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerFirstArraySelection ? pickerData[row] : pickerSecondData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //self.txt_pickUpData.text = pickerData[row]
        
    
        if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.CF_SEC_PERSONAL_INFO_F2 {
            (item as? FormTextField)?.fields?[textfieldTagValue].value = pickerData[row]
            textFields[textfieldTagValue].text = pickerData[row]
        } else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_PERSONAL_INFORMATION_F2 {
            (item as? FormTextField)?.fields?[textfieldTagValue].value = pickerData[row]
            textFields[textfieldTagValue].text = pickerData[row]
        } else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F05 {
            (item as? FormTextField)?.fields?[textfieldTagValue].value = pickerData[row]
            textFields[textfieldTagValue].text = pickerData[row]
        } else if  (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F08 {
            (item as? FormTextField)?.fields?[textfieldTagValue].value = pickerData[row]
            textFields[textfieldTagValue].text = pickerData[row]
        } else if  (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F09 {
            (item as? FormTextField)?.fields?[textfieldTagValue].value = pickerData[row]
            textFields[textfieldTagValue].text = pickerData[row]
        } else if  (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F13 {
            (item as? FormTextField)?.fields?[textfieldTagValue].value = pickerData[row]
            textFields[textfieldTagValue].text = pickerData[row]
        } else if  (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F17 {
            (item as? FormTextField)?.fields?[textfieldTagValue].value = pickerData[row]
            textFields[textfieldTagValue].text = pickerData[row]
        } else if  (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F19 {
            (item as? FormTextField)?.fields?[textfieldTagValue].value = pickerData[row]
            textFields[textfieldTagValue].text = pickerData[row]
        } else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F23  {
            textFields[textfieldTagValue].text = pickerSecondData[row]
        }
        else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F24  {
            textFields[textfieldTagValue].text = pickerData[row]
        }
        else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F24  {
            textFields[textfieldTagValue].text = pickerData[row]
        }
        else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F25  {
            textFields[textfieldTagValue].text = pickerData[row]
        }
        else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F26  {
            textFields[textfieldTagValue].text = pickerData[row]
        }
        else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F27  {
            textFields[textfieldTagValue].text = pickerSecondData[row]
        }
        else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F29  {
            textFields[textfieldTagValue].text = pickerData[row]
        }
    }
}

extension FormCell {
    
    func pickerView(_ textField : UITextField){
        
        // UIPickerView
        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: 216))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        textField.inputView = self.myPickerView
        
        //set the picker
        if ((item as? FormTextField)?.fields?[textField.tag].value as? String) == "No" {
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
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    
    @objc func doneClick() {
        
        if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.CF_SEC_PERSONAL_INFO_F2 {
            if textFields[textfieldTagValue].text == "" {
                (item as? FormTextField)?.fields?[textfieldTagValue].value = "Yes"
                textFields[textfieldTagValue].text = "Yes"
            }
            textFields[textfieldTagValue].resignFirstResponder()
        } else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_PERSONAL_INFORMATION_F2 {
            if textFields[textfieldTagValue].text == "" {
                 (item as? FormTextField)?.fields?[textfieldTagValue].value = "Yes"
                textFields[textfieldTagValue].text = "Yes"
            }
            textFields[textfieldTagValue].resignFirstResponder()
        } else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F05 {
            if textFields[textfieldTagValue].text == "" {
                 (item as? FormTextField)?.fields?[textfieldTagValue].value = "Yes"
                textFields[textfieldTagValue].text = "Yes"
            }
            textFields[textfieldTagValue].resignFirstResponder()
        } else if  (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F08 {
            if textFields[textfieldTagValue].text == "" {
                 (item as? FormTextField)?.fields?[textfieldTagValue].value = "Yes"
                textFields[textfieldTagValue].text = "Yes"
            }
            textFields[textfieldTagValue].resignFirstResponder()
        } else if  (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F09 {
            if textFields[textfieldTagValue].text == "" {
                 (item as? FormTextField)?.fields?[textfieldTagValue].value = "Yes"
                textFields[textfieldTagValue].text = "Yes"
            }
            textFields[textfieldTagValue].resignFirstResponder()
        } else if  (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F13 {
            if textFields[textfieldTagValue].text == "" {
                 (item as? FormTextField)?.fields?[textfieldTagValue].value = "Yes"
                textFields[textfieldTagValue].text = "Yes"
            }
            textFields[textfieldTagValue].resignFirstResponder()
        } else if  (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F17 {
            if textFields[textfieldTagValue].text == "" {
                 (item as? FormTextField)?.fields?[textfieldTagValue].value = "Yes"
                textFields[textfieldTagValue].text = "Yes"
            }
            textFields[textfieldTagValue].resignFirstResponder()
        } else if  (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F19 {
            if textFields[textfieldTagValue].text == "" {
                (item as? FormTextField)?.fields?[textfieldTagValue].value = "Yes"
                textFields[textfieldTagValue].text = "Yes"
            }
            textFields[textfieldTagValue].resignFirstResponder()
        } else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F23  {
            if textFields[textfieldTagValue].text == "" {
                (item as? FormTextField)?.fields?[textfieldTagValue].value = "5"
                textFields[textfieldTagValue].text = "5"
            }
            (item as? FormTextField)?.fields?[textfieldTagValue].value = textFields[textfieldTagValue].text
            textFields[textfieldTagValue].resignFirstResponder()
        }
        else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F24  {
            if textFields[textfieldTagValue].text == "" {
                (item as? FormTextField)?.fields?[textfieldTagValue].value = "Yes"
                textFields[textfieldTagValue].text = "Yes"
            }
            (item as? FormTextField)?.fields?[textfieldTagValue].value = textFields[textfieldTagValue].text
            textFields[textfieldTagValue].resignFirstResponder()
        }
        else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F25  {
            if textFields[textfieldTagValue].text == "" {
                (item as? FormTextField)?.fields?[textfieldTagValue].value = "Yes"
                textFields[textfieldTagValue].text = "Yes"
            }
            (item as? FormTextField)?.fields?[textfieldTagValue].value = textFields[textfieldTagValue].text
            textFields[textfieldTagValue].resignFirstResponder()
        }
        else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F26  {
            if textFields[textfieldTagValue].text == "" {
                (item as? FormTextField)?.fields?[textfieldTagValue].value = "Yes"
                textFields[textfieldTagValue].text = "Yes"
            }
            (item as? FormTextField)?.fields?[textfieldTagValue].value = textFields[textfieldTagValue].text
            textFields[textfieldTagValue].resignFirstResponder()
        }
        else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F27  {
            if textFields[textfieldTagValue].text == "" {
                (item as? FormTextField)?.fields?[textfieldTagValue].value = "5"
                textFields[textfieldTagValue].text = "5"
            }
            (item as? FormTextField)?.fields?[textfieldTagValue].value = textFields[textfieldTagValue].text
            textFields[textfieldTagValue].resignFirstResponder()
        }
        else if (item as? FormTextField)?.fields?[textfieldTagValue].placeHolder == VCLiteral.PF_SECTION_FINANCIAL_DATA_F29  {
            if textFields[textfieldTagValue].text == "" {
                (item as? FormTextField)?.fields?[textfieldTagValue].value = VCLiteral.CF_PROTECTION_ONLY.localized
                textFields[textfieldTagValue].text = VCLiteral.CF_PROTECTION_ONLY.localized
            }
            (item as? FormTextField)?.fields?[textfieldTagValue].value = textFields[textfieldTagValue].text
            textFields[textfieldTagValue].resignFirstResponder()
        }
    }
}

