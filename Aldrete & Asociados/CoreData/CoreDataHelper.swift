//
//  CoreDataHelper.swift
//  Aldrete & Asociados
//
//  Created by Sandeep Kumar on 29/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

enum EntityName: String {
    case PersonalInfo = "PersonFormCD"
    case ContactInfo = "ContactInfoCD"
    case CompanyFormCD = "CompanyFormCD"
    case MeetingCD = "MeetingCD"
    case FinancialDataCD = "FinancialDataCD"
    case ChildrenOrDependentsCD = "ChildrenOrDependentsCD"
}

class CoreDataHelper {
    
    static let shared = CoreDataHelper()
    var id = 1
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveForm(formType: FormType, data: ModelsFields) {
        
        switch formType {
        case .Person:
            savePersonalForm(data: data)
            break
        case .Company:
            saveCompanyForm(data: data)
            break
        default:
            print("default Case.")
        }
    }
    
    
    func getCompanyInfo() {
        
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: EntityName.CompanyFormCD.rawValue)
            let response = try context.fetch(fetchRequest)
            debugPrint(response)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    
    func saveMeeting(meetingModel: AddMeetingModel, formType: Int16) {
        
        
        print(meetingModel.meetingStartTime)
        print(meetingModel.meetingEndTime)
        
        let meetingForm = MeetingCD(context: context)
        meetingForm.formType =  formType
        meetingForm.meetingId = UUID().uuidString
        meetingForm.meetingTitle = meetingModel.meetingName
        meetingForm.date = meetingModel.meetingDate
        meetingForm.startTime = meetingModel.meetingStartTime
        meetingForm.endTime = meetingModel.meetingEndTime
        meetingForm.userId = meetingModel.userId
        meetingForm.presentation =  meetingModel.presentation
        meetingForm.location = meetingModel.location
        meetingForm.userName = meetingModel.userName
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    
    func saveContact(addContactModel: AddContactModel) {
        
        let contactDetails = ContactPhoneNumberCD(context: context)
        contactDetails.contactId = UUID().uuidString
        contactDetails.contactType = addContactModel.contactType
        contactDetails.contactNumber = addContactModel.contactNumber
        contactDetails.userId = addContactModel.userId
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    
    func savePersonalForm(data: ModelsFields) {

        let personForm = PersonFormCD(context: context)
        personForm.created = Date()
        personForm.userId = data.contact_userId
        
        let contactInfo = ContactInfoCD(context: context)
        contactInfo.fullName = data.contact_fullName
        contactInfo.email = data.contact_email
        contactInfo.whatsAppNo = data.contact_whatsAppNumber
        contactInfo.userId = data.contact_userId
        contactInfo.formType = 1
        contactInfo.status = "Warm"
        personForm.contactInfo = contactInfo
        
        let personalInfo = PersonalInfoCD(context: context)
        personalInfo.userId = data.contact_userId
        personalInfo.dob = data.personal_dob
        personalInfo.smoke = data.personal_smoke ?? false
        personalInfo.spouseName = data.personal_spouseName
        personForm.personalInfo = personalInfo
        
        var childrenDependents = [ChildrenOrDependentsCD]()
        data.childrenDependent.forEach { (childerenDependentValue) in
            let childrenDependent = ChildrenOrDependentsCD(context: context)
            childrenDependent.fullName = childerenDependentValue.children_fullname
            childrenDependent.dob = childerenDependentValue.children_dob
            childrenDependent.userId = data.contact_userId
            childrenDependent.id = UUID().uuidString
            childrenDependents.append(childrenDependent)
        }
        
        personForm.childreanOrDependents = NSSet.init(set: Set(childrenDependents))
        
        let financial = FinancialDataCD(context: context)
        
        financial.monthlyFixedCost = data.financial_monthlyFixedCost ?? 0
        financial.monthlyVariableExpenses = data.financial_monthlyVaraibleExpenses ?? 0
        financial.percentageThatCoverExpenses = data.financial_percentageThatCoverExpenses ?? 0
        
        financial.percentageCoveringExpensesElla = data.financial_percentageCoveringExpenses ?? 0
        financial.isGMM_Insurance = data.financial_theyHaveGmmInsurance ?? false
        financial.company = data.financial_comapny
        
        financial.sumSecuredMXN = data.financial_sumSecuredMXN ?? 0
        financial.isWill = data.financial_theyWillHaveSumSecuredMXN ?? false
        financial.isDebt = data.financial_theyDebtSumSecuredMXN ?? false
        
        financial.whatDebts = data.financial_whatDebts
        
        financial.financialGoals = data.financial_mostImportantFinancialGoals
        financial.doingToReachThem = data.financial_whatAreDoingToReachThem
        financial.isMoneySaved = data.financial_haveYouSavedMoney ?? false
        
        financial.howMuchMoney = data.financial_howMuchMoney$MNX ?? 0
        financial.instrument = data.financial_inWhatInstrument
        
        financial.nominee = data.financial_inCaseOfPrematureDeathWhoWillBeResponsibleOfYourFamily
        
        financial.isContigencyPlan = data.financial_haveAContingencyPlanInCaseOfDisabblity ?? false
        financial.contingencyPlan = data.financial_contingencyPlan
        
        financial.isFinanacialPlanOfRetirement = data.financial_youHaveAFinancialPlanOfRetriement ?? false
        financial.retirementPlan = data.financial_whatThePlan
        financial.retireAge = data.financial_atWhatAgeWouldYouLikeToRetire ?? 0
        
        financial.presentProposalDate = data.financial_dateOfMeeting
        financial.howManyYearForFamily = data.financial_howManyYearForFamily

        financial.doYouhaveSpouse = data.financial_doYouhaveSpouse
        financial.retirement = data.financial_retirement
        financial.mortgagePayment = data.financial_mortgagePayment
        financial.insured = data.financial_insured
        financial.moneyNeedByFamily = data.financial_moneyNeedByFamily
        financial.protection = data.financial_protection
        
        financial.userId = data.contact_userId
        personForm.financialData = financial
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    }
    
    //Save Company Data
    func saveCompanyForm(data: ModelsFields) {
        let companyForm = CompanyFormCD(context: context)
        companyForm.created = Date()
        companyForm.userId = data.contact_userId

        let contactInfo = ContactInfoCD(context: context)
        contactInfo.fullName = data.contact_fullName
        contactInfo.email = data.contact_email
        contactInfo.whatsAppNo = data.contact_whatsAppNumber
        contactInfo.formType = 0
        contactInfo.userId = data.contact_userId
        contactInfo.status = data.contactStatus
        contactInfo.dateOfMeetingProposal = data.financial_dateOfMeeting
        companyForm.contactInfo = contactInfo

        let personalInfo = PersonalInfoCD(context: context)
        personalInfo.dob = data.personal_dob
        personalInfo.userId = data.contact_userId
        personalInfo.smoke = data.personal_smoke ?? false
        companyForm.personalInfo = personalInfo

        var keyMenInfo = [KeyMenCD]()
        data.keyMen.forEach { (keyMenValue) in
            let keyMen = KeyMenCD(context: context)
            keyMen.fullName = keyMenValue.keyMen_fullName
            keyMen.dob = keyMenValue.keyMen_dob
            keyMen.sharePercentageMember = Int64(keyMenValue.keyMen_sharePercentage ?? 0)
            keyMen.smoke = keyMenValue.keyMen_Smoke ?? false
            keyMen.prizeAmount = Int64(keyMenValue.keyMen_prizeAmount ?? 0)
            keyMen.defferedCompensation = keyMenValue.keyMen_DefferedCompensation
            keyMen.userId = data.contact_userId
            keyMen.id = UUID().uuidString
            keyMenInfo.append(keyMen)
        }
        
        companyForm.keyMen = NSSet.init(set: Set(keyMenInfo))
        (UIApplication.shared.delegate as! AppDelegate).saveContext()

    }
    
    //Fetch
    func fetch(entityName: EntityName, completion: (_ result: Any?, _ success: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName.rawValue)
            let companyData =  try managedContext.fetch(request)
            completion(companyData, true)
            print("Sucessfully fetch")
            
        } catch {
            debugPrint("Could not fetch the request data\(error.localizedDescription)")
            completion(nil,false)
        }
    }
    
    //Fetch data using user id.
    func fetchWithUserID(userID: String, entityName: String, completion: (_ result: Any?, _ success: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            request.predicate = NSPredicate(format: "userId = %@", userID)
            let data = try managedContext.fetch(request)

            //let companyData =  try managedContext.fetch(request)
            completion(data, true)
            print("Sucessfully fetch")
            
        } catch {
            debugPrint("Could not fetch the request data\(error.localizedDescription)")
            completion(nil,false)
        }
    }
    
    
   //Save Status
    func saveStatus(userID: String, status: String ,completion: (_ success: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ContactInfoCD")
            request.predicate = NSPredicate(format: "userId = %@", userID)
            let data = try managedContext.fetch(request)
            
            for object in data as? [ContactInfoCD] ?? [] {
                
                if object.userId == userID {
                    object.status = status
                }
            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            completion(true)
            print("Sucessfully fetch")
            
        } catch {
            debugPrint("Could not fetch the request data\(error.localizedDescription)")
            completion(false)
        }
    }
    
    //Save Notes.
    func saveNotes(userID: String, notes: String ,completion: (_ success: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ContactInfoCD")
            request.predicate = NSPredicate(format: "userId = %@", userID)
            let data = try managedContext.fetch(request)
            
            for object in data as? [ContactInfoCD] ?? [] {
                
                if object.userId == userID {
                    object.notes = notes
                }
                
            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            completion(true)
            print("Sucessfully fetch")
            
        } catch {
            debugPrint("Could not fetch the request data\(error.localizedDescription)")
            completion(false)
        }
    }
    
    //Delete Contact
    func deleteContact(userID: String, completion: ( _ success: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        do {
            
            let contactRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ContactInfoCD")
            contactRequest.predicate = NSPredicate(format: "userId = %@", userID)
            let contactData = try managedContext.fetch(contactRequest)
            for obj in contactData {
                context.delete(obj as! NSManagedObject)
            }
            
            let companyRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CompanyFormCD")
            companyRequest.predicate = NSPredicate(format: "userId = %@", userID)
            let companyData = try managedContext.fetch(companyRequest)
            for obj in companyData {
                context.delete(obj as! NSManagedObject)
            }
            
            let contactPhonesRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ContactPhoneNumberCD")
            contactPhonesRequest.predicate = NSPredicate(format: "userId = %@", userID)
            let contactPhonesData = try managedContext.fetch(contactPhonesRequest)
            for obj in contactPhonesData {
                context.delete(obj as! NSManagedObject)
            }
            
            
            let meetingRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MeetingCD")
            meetingRequest.predicate = NSPredicate(format: "userId = %@", userID)
            let meetingData = try managedContext.fetch(meetingRequest)
            for obj in meetingData {
                context.delete(obj as! NSManagedObject)
            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            //let companyData =  try managedContext.fetch(request)
            completion(true)
            print("Sucessfully fetch")
            
        } catch {
            debugPrint("Could not fetch the request data\(error.localizedDescription)")
            completion(false)
        }
    }
    
    
    //Delete Meeting
    func deleteMeeting(meetingID: String, completion: ( _ success: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        do {
            
            let meetingRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MeetingCD")
            meetingRequest.predicate = NSPredicate(format: "meetingId = %@", meetingID)
            let meetingData = try managedContext.fetch(meetingRequest)
            for obj in meetingData {
                context.delete(obj as! NSManagedObject)
            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            //let companyData =  try managedContext.fetch(request)
            completion(true)
            print("Sucessfully fetch")
            
        } catch {
            debugPrint("Could not fetch the request data\(error.localizedDescription)")
            completion(false)
        }
    }
    
    
    
    //Update company data
    func updateCompanyData(userID: String?, modelfields: ModelsFields, completion: (_ success: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        do {
            
            //Contact Information
            let contactRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ContactInfoCD")
            contactRequest.predicate = NSPredicate(format: "userId = %@", userID!)
            let contactData = try managedContext.fetch(contactRequest)
            for object in contactData as? [ContactInfoCD] ?? [] {
                
                if object.userId == userID {
                    object.dateOfMeetingProposal = modelfields.financial_dateOfMeeting
                    object.fullName = modelfields.contact_fullName
                    object.email = modelfields.contact_email
                    object.whatsAppNo = modelfields.contact_whatsAppNumber
                }
                
            }
            
            //Personal Information
            let personalRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonalInfoCD")
            personalRequest.predicate = NSPredicate(format: "userId = %@", userID!)
            let personalData = try managedContext.fetch(personalRequest)
            for object in personalData as? [PersonalInfoCD] ?? [] {
                
                if object.userId == userID {
                    object.dob = modelfields.personal_dob
                    object.smoke = modelfields.personal_smoke ?? false 
                }
                
            }
            
            
            //Keymen Information
            let keymenRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "KeyMenCD")
            keymenRequest.predicate = NSPredicate(format: "userId = %@", userID!)
           
            let keyMenRequestData = try managedContext.fetch(keymenRequest)
            for obj in keyMenRequestData {
                context.delete(obj as! NSManagedObject)
            }
            
            var keyMenInfo = [KeyMenCD]()
            modelfields.keyMen.forEach { (keyMenValue) in
                let keyMen = KeyMenCD(context: context)
                keyMen.fullName = keyMenValue.keyMen_fullName
                keyMen.dob = keyMenValue.keyMen_dob
                keyMen.sharePercentageMember = Int64(keyMenValue.keyMen_sharePercentage ?? 0)
                keyMen.smoke = keyMenValue.keyMen_Smoke ?? false
                keyMen.prizeAmount = Int64(keyMenValue.keyMen_prizeAmount ?? 0)
                keyMen.defferedCompensation = keyMenValue.keyMen_DefferedCompensation
                keyMen.userId = userID
                keyMen.id = UUID().uuidString
                keyMenInfo.append(keyMen)
            }
            
            
            //Company Form
            let companyForm = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.CompanyFormCD.rawValue)
            companyForm.predicate = NSPredicate(format: "userId = %@", userID!)
            let companyFormData = try managedContext.fetch(companyForm)
            for object in companyFormData as? [CompanyFormCD] ?? [] {
                if object.userId == userID {
                    object.keyMen = NSSet.init(set: Set(keyMenInfo))
                }
            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            completion(true)
            
        } catch {
            debugPrint("Could not fetch the request data\(error.localizedDescription)")
            completion(false)
        }
        
    }
    
    
    
    //Update Personal Form
    func updatePersonalForm(userID: String?, modelfields: ModelsFields, completion: (_ success: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        do {
            
            //Contact Information
            let contactRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ContactInfoCD")
            contactRequest.predicate = NSPredicate(format: "userId = %@", userID!)
            let contactData = try managedContext.fetch(contactRequest)
            for object in contactData as? [ContactInfoCD] ?? [] {
                
                if object.userId == userID {
                    object.dateOfMeetingProposal = modelfields.financial_dateOfMeeting
                    object.fullName = modelfields.contact_fullName
                    object.email = modelfields.contact_email
                    object.whatsAppNo = modelfields.contact_whatsAppNumber
                }
                
            }
            
            //Personal Information
            let personalRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonalInfoCD")
            personalRequest.predicate = NSPredicate(format: "userId = %@", userID!)
            let personalData = try managedContext.fetch(personalRequest)
            for object in personalData as? [PersonalInfoCD] ?? [] {
                
                if object.userId == userID {
                    object.dob = modelfields.personal_dob
                    object.smoke = modelfields.personal_smoke ?? false
                }
                
            }
            
            //Company Form
            let financialCD = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.FinancialDataCD.rawValue)
            financialCD.predicate = NSPredicate(format: "userId = %@", userID!)
            let financialData = try managedContext.fetch(financialCD)
            for object in financialData as? [FinancialDataCD] ?? [] {
                if object.userId == userID {
                    object.monthlyFixedCost = modelfields.financial_monthlyFixedCost ?? 0
                    object.monthlyVariableExpenses = modelfields.financial_monthlyVaraibleExpenses ?? 0
                    object.percentageThatCoverExpenses = modelfields.financial_percentageThatCoverExpenses ?? 0
                    
                    object.percentageCoveringExpensesElla = modelfields.financial_percentageCoveringExpenses ?? 0
                    object.isGMM_Insurance = modelfields.financial_theyHaveGmmInsurance ?? false
                    object.company = modelfields.financial_comapny
                    
                    object.sumSecuredMXN = modelfields.financial_sumSecuredMXN ?? 0
                    object.isWill = modelfields.financial_theyWillHaveSumSecuredMXN ?? false
                    object.isDebt = modelfields.financial_theyDebtSumSecuredMXN ?? false
                    
                    object.whatDebts = modelfields.financial_whatDebts
                    
                    object.financialGoals = modelfields.financial_mostImportantFinancialGoals
                    object.doingToReachThem = modelfields.financial_whatAreDoingToReachThem
                    object.isMoneySaved = modelfields.financial_haveYouSavedMoney ?? false
                    
                    object.howMuchMoney = modelfields.financial_howMuchMoney$MNX ?? 0
                    object.instrument = modelfields.financial_inWhatInstrument
                    
                    object.nominee = modelfields.financial_inCaseOfPrematureDeathWhoWillBeResponsibleOfYourFamily
                    
                    object.isContigencyPlan = modelfields.financial_haveAContingencyPlanInCaseOfDisabblity ?? false
                    object.contingencyPlan = modelfields.financial_contingencyPlan
                    
                    object.isFinanacialPlanOfRetirement = modelfields.financial_youHaveAFinancialPlanOfRetriement ?? false
                    object.retirementPlan = modelfields.financial_whatThePlan
                    object.retireAge = modelfields.financial_atWhatAgeWouldYouLikeToRetire ?? 0
                    
                    object.presentProposalDate = modelfields.financial_dateOfMeeting
                    object.howManyYearForFamily = modelfields.financial_howManyYearForFamily
                   
                   
                    object.doYouhaveSpouse = modelfields.financial_doYouhaveSpouse
                    object.retirement = modelfields.financial_retirement
                    object.mortgagePayment = modelfields.financial_mortgagePayment
                    object.insured = modelfields.financial_insured
                    object.moneyNeedByFamily = modelfields.financial_moneyNeedByFamily
                    object.protection = modelfields.financial_protection
                    
                }
            }
            
            
            //Keymen Information
            let childrenOrDependentsRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ChildrenOrDependentsCD")
            childrenOrDependentsRequest.predicate = NSPredicate(format: "userId = %@", userID!)
            
            let childrenOrDependentsRequestRequestData = try managedContext.fetch(childrenOrDependentsRequest)
            for obj in childrenOrDependentsRequestRequestData {
                context.delete(obj as! NSManagedObject)
            }
            
            var childrenOrDependentsInfo = [ChildrenOrDependentsCD]()
            modelfields.childrenDependent.forEach { (childrenDependantValue) in
                let childrenOrDependents = ChildrenOrDependentsCD(context: context)
                childrenOrDependents.dob = childrenDependantValue.children_dob
                childrenOrDependents.fullName = childrenDependantValue.children_fullname
                childrenOrDependents.userId = userID
                childrenOrDependents.id = UUID().uuidString
                childrenOrDependentsInfo.append(childrenOrDependents)
            }
            
            
            //Company Form
            let personalForm = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.PersonalInfo.rawValue)
            personalForm.predicate = NSPredicate(format: "userId = %@", userID!)
            let personalFormData = try managedContext.fetch(personalForm)
            for object in personalFormData as? [PersonFormCD] ?? [] {
                if object.userId == userID {
                    object.childreanOrDependents = NSSet.init(set: Set(childrenOrDependentsInfo))
                }
            }
            
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            completion(true)
            
        } catch {
            debugPrint("Could not fetch the request data\(error.localizedDescription)")
            completion(false)
        }
    }
    
    
    //Update company data
    func updateMeetingData(meetingId: String?, modelfields: AddMeetingModel, completion: (_ success: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        do {
            
            let meetingRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MeetingCD")
            meetingRequest.predicate = NSPredicate(format: "meetingId = %@", /meetingId)
            let meetingData = try managedContext.fetch(meetingRequest)
            for object in meetingData as? [MeetingCD] ?? [] {
                
                if object.meetingId == meetingId {
                    object.meetingTitle = modelfields.meetingName
                    object.date = modelfields.meetingDate
                    object.startTime = modelfields.meetingStartTime
                    object.endTime = modelfields.meetingEndTime
                    object.presentation =  modelfields.presentation
                    object.location = modelfields.location
                }
                
            }
            
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            completion(true)
            
        } catch {
            debugPrint("Could not fetch the request data\(error.localizedDescription)")
            completion(false)
        }
        
    }
}
