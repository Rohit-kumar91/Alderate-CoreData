//
//  ModelFields.swift
//  Aldrete & Asociados
//
//  Created by NewMacMini1 on 01/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import Foundation

class ModelsFields {

    var contact_userId: String?
    var contact_fullName: String?
    var contact_email: String?
    var contact_whatsAppNumber: String?
    var contactStatus: String? = VCLiteral.WARM.localized
    
    var personal_userId: String?
    var personal_dob: Date?
    var personal_smoke: Bool?
    var personal_spouseName: String?
    
    var children_fullName:String?
    var childern_dob: String?
    
    var financial_monthlyFixedCost: Int64?
    var financial_monthlyVaraibleExpenses: Int64?
    var financial_percentageThatCoverExpenses: Int64?
    
    var financial_percentageCoveringExpenses: Int64?
    var financial_theyHaveGmmInsurance: Bool?
    var financial_comapny: String?
    
    var financial_sumSecuredMXN: Int64?
    var financial_theyWillHaveSumSecuredMXN: Bool?
    var financial_theyDebtSumSecuredMXN: Bool?
    
    var financial_whatDebts: String?
    
    var financial_mostImportantFinancialGoals: String?
    var financial_whatAreDoingToReachThem: String?
    var financial_haveYouSavedMoney: Bool?
    
    var financial_howMuchMoney$MNX: Int64?
    var financial_inWhatInstrument: String?
    
    var financial_inCaseOfPrematureDeathWhoWillBeResponsibleOfYourFamily: String?
    
    var financial_haveAContingencyPlanInCaseOfDisabblity: Bool?
    var financial_contingencyPlan : String?
    
    var financial_youHaveAFinancialPlanOfRetriement: Bool?
    var financial_whatThePlan: String?
    var financial_atWhatAgeWouldYouLikeToRetire: Int16?
    
    var financial_dateOfMeeting: Date?
    
    var financial_how_many_year_you_want_family_covered : String?
    
    var financial_userId: String?
    var financial_howManyYearForFamily: String?
    var financial_doYouhaveSpouse: String?
    var financial_retirement: String?
    var financial_mortgagePayment: String?
    var financial_insured: String?
    var financial_moneyNeedByFamily: String?
    
    var financial_protection: String?
    
    var keyMen = [KeyMenModels]()
    var childrenDependent = [ChildrenDependent]()
    
}

class KeyMenModels {
    var keyMen_fullName: String?
    var keyMen_dob: Date?
    var keyMen_sharePercentage: Int?
    var keyMen_Smoke: Bool?
    var keyMen_prizeAmount: Int?
    var keyMen_DefferedCompensation: String?
    var keymen_userId: String?
}

class ChildrenDependent {
    var childern_dependent_userId: String?
    var children_fullname: String?
    var children_dob: Date?
}

class AddContactModel{
    var contactType: String?
    var contactNumber: String?
    var userId: String?
}


class AddMeetingModel {
    var meetingName: String?
    var meetingDate: Date?
    var meetingStartTime: Date?
    var meetingEndTime: Date?
    var meetingId: String?
    var location: String?
    var presentation: String?
    var userId: String?
    var userName: String?
    
    
}


