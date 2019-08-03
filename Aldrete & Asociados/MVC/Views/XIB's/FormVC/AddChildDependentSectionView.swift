//
//  AddChildDependentSectionView.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 01/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class AddChildDependentSectionView: UITableViewHeaderFooterView, ReusableHeaderFooter {
  
  typealias T = FormModel
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var txtField1: UITextField!
  @IBOutlet weak var txtField2: UITextField!
  @IBOutlet weak var btnAdd: UIButton!
    
    
  
  var didTapAdd: ((_ item: FormModel?) -> Void)?
  var datePicker:UIDatePicker!

  var item: FormModel? {
    didSet {
        
      txtField1.delegate = self
      txtField2.delegate = self
      lblTitle.text = /item?.other?.title
      txtField1.placeholder = VCLiteral.PF_SECTION_CHILDREN_DEPENDENTS_F1.localized
      txtField2.placeholder = VCLiteral.PF_SECTION_CHILDREN_DEPENDENTS_F2.localized
      btnAdd.setTitle(VCLiteral.PF_SECTION_CHILDREN_DEPENDENTS_ADD_TITLE.localized, for: .normal)
    }
  }
  
  @IBAction func btnAddAction(_ sender: Any) {
    didTapAdd?(item)
    txtField1.text = ""
    txtField2.text = ""
  }
  
}

extension AddChildDependentSectionView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.placeholder == VCLiteral.PF_SECTION_CHILDREN_DEPENDENTS_F2.localized {
          textField.autocorrectionType = .no
        }
        
        if textField == txtField2 {
            setDateValue(textfield: textField)
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.textInputMode?.primaryLanguage == "emoji") || !((textField.textInputMode?.primaryLanguage) != nil) {
            return false
        }
        
        var str:NSString = textField.text! as NSString
        str = str.replacingCharacters(in: range, with: string) as NSString
        
        
        if textField.placeholder == VCLiteral.PF_SECTION_CHILDREN_DEPENDENTS_F1.localized {
            print("1")
            (item)?.tf1Value = str
        }
        
        if textField.placeholder == VCLiteral.PF_SECTION_CHILDREN_DEPENDENTS_F2.localized {
            print("2")
            (item)?.tf2Value = str
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
        txtField2.text = datePicker.date.string(format: "dd/MM/yyyy")
        txtField2.resignFirstResponder()
        
    }
}


