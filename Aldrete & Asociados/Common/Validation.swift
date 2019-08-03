//
//  Validation.swift
//  Aldrete & Asociados
//
//  Created by Sandeep Kumar on 30/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import Foundation
import CoreData

class Validate {
    
    static let shared = Validate()
    let phoneMaxLength = 16
    let phoneMinLength = 8
    var type: FormType = .Company
    var profileFullData = [ProfileFullData]()
    var profileData : ProfileFullData?
    var editMain = Bool()

    func validateCompanyTextfields(items: [FormModel]?, completion: (_ errorMessage: String, _ result: Bool) -> ())  {
        
        
        if (items?[0].items?.first as? FormTextField)?.fields?[0].value == nil ||
            ((items?[0].items?.first as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_CF_SEC_CONTACT_INFO_F1.localized, false)
            
        } else if (items?[0].items?.first as? FormTextField)?.fields?[1].value == nil || ((items?[0].items?.first as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_CF_SEC_CONTACT_INFO_F2.localized, false)
            
        } else if !((items?[0].items?.first as? FormTextField)?.fields?[1].value as! String).isEmail {
            
            completion(VCLiteral.VD_CF_SEC_CONTACT_INFO_CORRECT_EMAIL.localized, false)
            
        } else if (items?[0].items?.first as? FormTextField)?.fields?[2].value == nil || ((items?[0].items?.first as? FormTextField)?.fields?[2].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_CF_SEC_CONTACT_INFO_F3.localized, false)
            
        } else if (((items?[0].items?.first as? FormTextField)?.fields?[2].value as! String).length > phoneMaxLength) ||
            (((items?[0].items?.first as? FormTextField)?.fields?[2].value as! String).length < phoneMinLength) ||
            !((items?[0].items?.first as? FormTextField)?.fields?[2].value as! String).containsNumberOnly() ||
            ((items?[0].items?.first as? FormTextField)?.fields?[2].value as! String).isContainsAllZeros() {
            
            completion(VCLiteral.VD_CF_SEC_CONTACT_INFO_CORRECT_WHATSAPP_NUMBER.localized, false)
            
        } else if (items?[1].items?.first as? FormTextField)?.fields?[0].value == nil || ((items?[1].items?.first as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_PERSONAL_INFORMATION_F1.localized, false)
            
        } else if (items?[1].items?.first as? FormTextField)?.fields?[1].value == nil || ((items?[1].items?.first as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_PERSONAL_INFORMATION_F2.localized, false)
            
        } else if (items?[3].items?.first as? FormTextField)?.fields?[0].value == nil || ((items?[3].items?.first as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_CF_SEC_DATE_OF_MEETING_F1.localized, false)
            
        } else {
            
            completion("", true)
            
        }
        
       
    }
    
    
    func validateKeyMenOfCompanyValue(addedItem: FormModel?, completion: (_ errorMessage: String, _ result: Bool) -> ()) {
        
        if addedItem?.tf1Value == nil ||
            (addedItem?.tf1Value as? String)?.trimWhiteSpace == "" {
            
             completion(VCLiteral.VD_CF_SEC_KEY_MEN_F1.localized, false)
            
        } else if addedItem?.tf2Value == nil ||
            (addedItem?.tf2Value as? String)?.trimWhiteSpace == "" {
            
             completion(VCLiteral.VD_CF_SEC_KEY_MEN_F2.localized, false)
            
        } else if addedItem?.tf3Value == nil ||
            (addedItem?.tf3Value as? String)?.trimWhiteSpace == "" {
            
             completion(VCLiteral.VD_CF_SEC_KEY_MEN_F3.localized, false)
            
        } else if (!(addedItem?.tf3Value as! String).containsNumberOnly() ||
            (addedItem?.tf3Value as! String).isContainsAllZeros()) {
            
            completion(VCLiteral.VD_CF_KEY_MEN_VALID_SHARE_PERCENTAGE_OF_MEMBER.localized, false)
            
        } else if addedItem?.tf4Value == nil ||
            (addedItem?.tf4Value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_CF_SEC_KEY_MEN_F4.localized, false)
            
        } else if addedItem?.tf5Value == nil ||
            (addedItem?.tf5Value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_CF_SEC_KEY_MEN_F5.localized, false)
            
        } else if (!(addedItem?.tf5Value as! String).containsNumberOnly() ||
            (addedItem?.tf5Value as! String).isContainsAllZeros()) {
            
            completion(VCLiteral.VD_CF_SEC_CONTACT_VALID_AMOUNT.localized, false)
            
        } else if addedItem?.tf6Value == nil ||
            (addedItem?.tf6Value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_CF_SEC_KEY_MEN_F6.localized, false)
            
        } else if (!(addedItem?.tf6Value as! String).containsNumberOnly() ||
            (addedItem?.tf6Value as! String).isContainsAllZeros()) {
            
            completion(VCLiteral.VD_CF_SEC_CONTACT_VALID_DEFFERED_COMPENSATION.localized, false)
            
        } else {
            completion("", true)
        }
        
    }
    
    
    func validatePersonTextfields(items: [FormModel]?, completion: (_ errorMessage: String, _ result: Bool) -> ()) {
        
        if (items?[0].items?.first as? FormTextField)?.fields?[0].value == nil ||
            ((items?[0].items?.first as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_CONTACT_INFORMATION_F1.localized, false)
            
        } else if (items?[0].items?.first as? FormTextField)?.fields?[1].value == nil ||
            ((items?[0].items?.first as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SEC_CONTACT_INFO_CORRECT_EMAIL.localized, false)
            
        } else if !((items?[0].items?.first as? FormTextField)?.fields?[1].value as! String).isEmail {
            
            completion(VCLiteral.VD_PF_SECTION_CONTACT_INFORMATION_F2.localized, false)
            
        } else if (items?[0].items?.first as? FormTextField)?.fields?[2].value == nil ||
            ((items?[0].items?.first as? FormTextField)?.fields?[2].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_CONTACT_INFORMATION_F3.localized, false)
            
        } else if (((items?[0].items?.first as? FormTextField)?.fields?[2].value as! String).length > phoneMaxLength) ||
            (((items?[0].items?.first as? FormTextField)?.fields?[2].value as! String).length < phoneMinLength) ||
            !((items?[0].items?.first as? FormTextField)?.fields?[2].value as! String).containsNumberOnly() ||
            ((items?[0].items?.first as? FormTextField)?.fields?[2].value as! String).isContainsAllZeros() {
            
            completion(VCLiteral.VD_CF_SEC_CONTACT_INFO_CORRECT_WHATSAPP_NUMBER.localized, false)
            
        } else if (items?[1].items?.first as? FormTextField)?.fields?[0].value == nil ||
            ((items?[1].items?.first as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_PERSONAL_INFORMATION_F1.localized, false)
            
        } else if (items?[1].items?.first as? FormTextField)?.fields?[1].value == nil ||
            ((items?[1].items?.first as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_PERSONAL_INFORMATION_F2.localized, false)
            
        } else if (items?[1].items?.first as? FormTextField)?.fields?[2].value == nil ||
            ((items?[1].items?.first as? FormTextField)?.fields?[2].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_PERSONAL_INFORMATION_F3.localized, false)
            
        } else if (items?[3].items?.first as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?.first as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F01.localized, false)
            
        } else if !((items?[3].items?.first as? FormTextField)?.fields?[0].value as! String).containsNumberOnly() {
            completion("Monthly cost MXN Should contain number only", false)
            
        } else if (items?[3].items?.first as? FormTextField)?.fields?[1].value == nil ||
            ((items?[3].items?.first as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F02.localized, false)
            
        } else if !((items?[3].items?.first as? FormTextField)?.fields?[1].value as! String).containsNumberOnly() {
            completion("Monthly varaible expenses MXN should contain number only", false)
            
        } else if (items?[3].items?.first as? FormTextField)?.fields?[2].value == nil ||
            ((items?[3].items?.first as? FormTextField)?.fields?[2].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F03.localized, false)
            
        } else if !((items?[3].items?.first as? FormTextField)?.fields?[2].value as! String).containsNumberOnly() {
            completion("Percentage cover expenses should contain number only", false)
            
        } else if (items?[3].items?[1] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[1] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F04.localized, false)
            
        } else if !((items?[3].items?[1] as? FormTextField)?.fields?[0].value as! String).containsNumberOnly() {
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_ONLY_NUMBER.localized, false)
            
        } else if (items?[3].items?[1] as? FormTextField)?.fields?[1].value == nil ||
            ((items?[3].items?[1] as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F05.localized, false)
            
        } else if (items?[3].items?[2] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[2] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F06.localized, false)
            
        } else if (items?[3].items?[2] as? FormTextField)?.fields?[1].value == nil ||
            ((items?[3].items?[2] as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F07.localized, false)
            
        } else if !((items?[3].items?[2] as? FormTextField)?.fields?[1].value as! String).containsNumberOnly() {
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F07_NUMBER_ONLY.localized, false)
            
        } else if (items?[3].items?[2] as? FormTextField)?.fields?[2].value == nil ||
            ((items?[3].items?[2] as? FormTextField)?.fields?[2].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F08.localized, false)
            
        } else if (items?[3].items?[3] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[3] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F09.localized, false)
            
        } else if (items?[3].items?[3] as? FormTextField)?.fields?[1].value == nil ||
            ((items?[3].items?[3] as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F10.localized, false)
            
        } else if (items?[3].items?[4] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[4] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F11.localized, false)
            
        } else if (items?[3].items?[4] as? FormTextField)?.fields?[1].value == nil ||
            ((items?[3].items?[4] as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F12.localized, false)
            
        } else if (items?[3].items?[4] as? FormTextField)?.fields?[2].value == nil ||
            ((items?[3].items?[4] as? FormTextField)?.fields?[2].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F13.localized, false)
            
        } else if (items?[3].items?[5] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[5] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F14.localized, false)
            
        }
//        else if !((items?[3].items?[5] as? FormTextField)?.fields?[0].value as! String).containsNumberOnly() {
//            completion("Por favor ingrese la cantidad correcta de MNX.", false)
//
//        }
        
        else if !((items?[3].items?[5] as? FormTextField)?.fields?[0].value as! String).containsNumberOnly() {
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F14_NUMBER_ONLY.localized, false)
            
        } else if (items?[3].items?[5] as? FormTextField)?.fields?[1].value == nil ||
            ((items?[3].items?[5] as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F15.localized, false)
            
        } else if (items?[3].items?[6] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[6] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F16.localized, false)
            
        } else if (items?[3].items?[7] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[7] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F17.localized, false)
            
        } else if (items?[3].items?[7] as? FormTextField)?.fields?[1].value == nil ||
            ((items?[3].items?[7] as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F18.localized, false)
            
        } else if (items?[3].items?[8] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[8] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F19.localized, false)
            
        } else if (items?[3].items?[8] as? FormTextField)?.fields?[1].value == nil ||
            ((items?[3].items?[8] as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F20.localized, false)
            
        } else if (items?[3].items?[9] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[9] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F21.localized, false)
            
        } else if (items?[3].items?[9] as? FormTextField)?.fields?[1].value == nil ||
            ((items?[3].items?[9] as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F22.localized, false)
            
        } else if (items?[3].items?[10] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[10] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F23.localized, false)
            
        }
        else if (items?[3].items?[11] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[11] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F24.localized, false)
            
        }
        else if (items?[3].items?[12] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[12] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F25.localized, false)
            
        }
        else if (items?[3].items?[13] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[13] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F26.localized, false)
            
        }
        else if (items?[3].items?[14] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[14] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F27.localized, false)
            
        }
        else if (items?[3].items?[15] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[15] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F28.localized, false)
            
        }
        else if (items?[3].items?[16] as? FormTextField)?.fields?[0].value == nil ||
            ((items?[3].items?[16] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_FINANCIAL_DATA_F29.localized, false)
            
        }
            
        
        else {
            completion("", true)
        }
        
    }
    
    
    func validateChildrenOrDependent(addedItem: FormModel?, completion: (_ errorMessage: String, _ result: Bool) -> ()) {
        
        if addedItem?.tf1Value == nil ||
            (addedItem?.tf1Value as? String)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_PF_SECTION_CHILDREN_DEPENDENTS_F1.localized, false)
            
        } else if addedItem?.tf2Value == nil ||
            (addedItem?.tf2Value as? String)?.trimWhiteSpace == "" {
            
             completion(VCLiteral.VD_PF_SECTION_CHILDREN_DEPENDENTS_F2.localized, false)
            
        } else {
            completion("", true)
        }
        
    }
    
    
    func validateAddMeetingTextfields(addMeeting: AddMeetingModel,  completion: (_ errorMessage: String, _ result: Bool) -> ()) {
        
        if addMeeting.meetingName == nil ||
            (addMeeting.meetingName)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_MEETING_MEETING_NAME.localized, false)
            
        } else if addMeeting.meetingStartTime == nil {
            
            completion(VCLiteral.VD_MEETING_MEETING_START_TIME.localized, false)
            
        } else if addMeeting.meetingEndTime == nil {
            
            completion(VCLiteral.VD_MEETING_MEETING_END_TIME.localized, false)
            
        } else if addMeeting.meetingStartTime!.isGreaterThan(addMeeting.meetingEndTime!) {
            
            completion(VCLiteral.VD_MEETING_MEETING_END_TIME_GREATER.localized, false)
            
        } else if addMeeting.meetingDate == nil {
            
            completion(VCLiteral.VD_MEETING_DATE.localized, false)
            
        } else if addMeeting.location == nil ||
            (addMeeting.location)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_MEETING_LOCATION.localized, false)
            
        } else if addMeeting.presentation == nil ||
            (addMeeting.presentation)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_MEETING_PRESENTATION.localized, false)
            
        } else {
            
            completion("", true)
            
        }
    }
    
    
    
    func validateAddContactTextfield(addContact: AddContactModel, completion: (_ errorMessage: String, _ result: Bool) -> ()) {
        
        if addContact.contactType == nil ||
            (addContact.contactType)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_CONTACT_TYPE.localized, false)
            
        } else if addContact.contactNumber == nil ||
            (addContact.contactNumber)?.trimWhiteSpace == "" {
            
            completion(VCLiteral.VD_CONTACT_NUMBER.localized, false)
            
        } else if (addContact.contactNumber!.length > phoneMaxLength) ||
            (addContact.contactNumber!.length < phoneMinLength) ||
            !addContact.contactNumber!.containsNumberOnly() ||
            addContact.contactNumber!.isContainsAllZeros() {
            completion(VCLiteral.VD_CONTACT_NUMBER.localized, false)
        }
        
        else {
            completion("", true)
        }
    }

}
