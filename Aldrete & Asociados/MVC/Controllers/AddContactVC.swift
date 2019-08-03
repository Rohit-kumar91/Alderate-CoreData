//
//  AddContactVC.swift
//  Aldrete & Asociados
//
//  Created by NewMacMini1 on 09/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class AddContactVC: UIViewController {

    @IBOutlet weak var contactTypeTextfield: UITextField!
    @IBOutlet weak var contactNumberTextfield: UITextField!
    
    var pickerView = UIPickerView()
    var pickerData = ["Work","Home","Office"]
    var addContact = AddContactModel()
    var value = String()
    var userID = String()
    var didTapFetchContactAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        value = pickerData[0]
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        Validate.shared.validateAddContactTextfield(addContact: addContact) { [weak self](errorMessage, success) in
            if success {
                addContact.userId = userID
                CoreDataHelper.shared.saveContact(addContactModel: addContact)
                didTapFetchContactAction?()
                self?.dismiss(animated: true, completion: nil)
                let alert = UIAlertController(title: VCLiteral.VD_CF_SUCCESS.localized, message: "Contact saved successfully.", preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: { (_) in
                }))
                self?.present(alert, animated: true, completion: nil)
                
            } else {
                alertWithDesc(desc: errorMessage)
            }
        }
    }
    
    
    func pickerView(_ textField : UITextField){
        
        // UIPickerView
        pickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        textField.inputView = pickerView
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = Colors.APP_THEME.uiColor
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(FormCell.cancelClick))
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneClick() {
        self.view.endEditing(true)
        contactTypeTextfield.text = value
    }
    
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddContactVC : UIPickerViewDelegate, UIPickerViewDataSource {
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
        value = pickerData[row]
    }
}

extension AddContactVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.autocorrectionType = .no
        switch textField.tag {
        case 1:
            //Contact Type
            pickerView(textField)
            break
        case 2:
            //Contact Number
            break
       
        default:
            print("Something went wrong.")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            //Contact Type
            addContact.contactType = value
            break
        case 2:
            //Contact Number
            addContact.contactNumber = textField.text
            break
        default:
            print("Something went wrong.")
        }
    }
}

