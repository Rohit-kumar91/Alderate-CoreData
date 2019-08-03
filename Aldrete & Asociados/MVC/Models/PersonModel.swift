//
//  PersonModel.swift
//  Aldrete & Asociados
//
//  Created by Rohit Prajapati on 04/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import Foundation

class FinancialModel {
    
    var company: String?
    var contingencyPlan: String?
    var doingToReachThem: String?
    var financialGoals: String?
    var howMuchMoney: Int64?
    var instrument: String?
    var isContigencyPlan: Bool?
    var isDebt: Bool?
    var isGMM_Insurance: Bool?
    var isMoneySaved: Bool?
    var isWill: Bool?
    var monthlyFixedCost: Int64?
    var monthlyVariableExpenses: Int64?
    var nominee: String?
    var percentageCoveringExpensesElla:Int64?
    var percentageThatCoverExpenses: Int64?
    var presentProposalDate: Date?
    var retireAge: Int16?
    var isRetirementPlan: Bool?
    var whatRetireMentPlan: String?
    var sumSecuredMXN: Int64?
    var userId: String?
    var whatDebts: String?
    var dateOfMeeting: Date?
    var familyLeaveRequirement: String?
    
    var doYouhaveSpouse: String?
    var retirement: String?
    var mortgagePayment: String?
    var insured: String?
    var moneyNeedByFamily: String?
    var protection: String?
    
    
    init(company: String?, contingencyPlan: String?, doingToReachThem: String?, financialGoals: String?, howMuchMoney: Int64?, instrument: String?, isContigencyPlan: Bool?, isDebt: Bool?, isGMM_Insurance: Bool?, isMoneySaved: Bool?, isWill: Bool?, monthlyFixedCost: Int64?, nominee: String?, percentageCoveringExpensesElla:Int64?, percentageThatCoverExpenses: Int64?, presentProposalDate: Date?, retireAge: Int16?, sumSecuredMXN: Int64?, userId: String?, whatDebts: String?, isRetirementPlan: Bool?, whatRetireMentPlan: String?, dateOfMeeting: Date?, fimilyLeaveRequirement: String?, monthlyVariableExpenses: Int64?,doYouhaveSpouse: String?,retirement: String?,mortgagePayment: String?,insured: String?,moneyNeedByFamily: String?,protection: String?) {
        
        self.company = company
        self.contingencyPlan = contingencyPlan
        self.doingToReachThem = doingToReachThem
        self.financialGoals = financialGoals
        self.howMuchMoney = howMuchMoney
        self.instrument = instrument
        self.isContigencyPlan = isContigencyPlan
        self.isDebt = isDebt
        self.isGMM_Insurance = isGMM_Insurance
        self.isMoneySaved = isMoneySaved
        self.isWill = isWill
        self.monthlyFixedCost = monthlyFixedCost
        self.nominee = nominee
        self.presentProposalDate = presentProposalDate
        self.retireAge = retireAge
        self.sumSecuredMXN = sumSecuredMXN
        self.userId = userId
        self.whatDebts = whatDebts
        self.isRetirementPlan = isRetirementPlan
        self.whatRetireMentPlan = whatRetireMentPlan
        self.dateOfMeeting = dateOfMeeting
        self.familyLeaveRequirement = fimilyLeaveRequirement
        self.monthlyVariableExpenses = monthlyVariableExpenses
        self.percentageThatCoverExpenses = percentageThatCoverExpenses
        self.percentageCoveringExpensesElla = percentageCoveringExpensesElla
        self.doYouhaveSpouse = doYouhaveSpouse
        self.retirement = retirement
        self.mortgagePayment = mortgagePayment
        self.insured = insured
        self.moneyNeedByFamily = moneyNeedByFamily
        self.protection = protection
        
    }
}


class ContactInfo {
    var status: String?
    var email: String?
    var formType: Int16?
    var fullName: String?
    var userId: String?
    var whatsAppNumber: String?
    var notes: String?
    var dateofMeetingOfProposal: Date?
   
    init(email: String?, formType: Int16?, fullName: String?, userId: String?,
         whatsAppNumber: String?, notes: String?, dateofMeetingOfProposal: Date?, status: String?) {
        self.email = email
        self.formType = formType
        self.fullName = fullName
        self.userId = userId
        self.whatsAppNumber = whatsAppNumber
        self.notes = notes
        self.dateofMeetingOfProposal = dateofMeetingOfProposal
        self.status = status
    }
}


class PersonalInfo {
    var dob: Date?
    var formType: Int16?
    var smoke: Bool?
    var spouseName: String?
    var userId: String?
    
    init(dob: Date?, formType: Int16?, smoke: Bool?, spouseName: String?, userId: String?) {
        self.dob = dob
        self.formType = formType
        self.smoke = smoke
        self.spouseName = spouseName
        self.userId = userId
    }
}

class KeyMen {
    
    var defferedCompensation: String?
    var dob: Date?
    var fullName: String?
    var prizeAmount: Int64?
    var sharePercentage: Int64?
    var smoke: Bool?
    
    init(defferedCompensation: String?, dob: Date?, fullName: String?, prizeAmount: Int64?, sharePercentage: Int64?, smoke: Bool?) {
        self.defferedCompensation = defferedCompensation
        self.dob = dob
        self.fullName = fullName
        self.prizeAmount = prizeAmount
        self.sharePercentage = sharePercentage
        self.smoke = smoke
    }
    
}

class ChilderenOrDependents {
    var dob: Date?
    var fullName: String?
    var id: String?
    var userId: String?
    
    init( dob: Date?, fullName: String?, id: String?, userId: String?) {
        self.dob = dob
        self.fullName = fullName
        self.id = id
        self.userId = userId
    }
}


class ProfileFullData {
    
    var created : Date?
    var userId: String?
    var childreanOrDependents: [ChilderenOrDependents]?
    var contactInfo: ContactInfo?
    var financialData: FinancialModel?
    var personalInfo: PersonalInfo?
    var keyMen: [KeyMen]?

    //Person
    init(created : Date?,userId: String?,childreanOrDependents: [ChilderenOrDependents]?,contactInfo: ContactInfo?,financialData: FinancialModel?,personalInfo: PersonalInfo?) {
        
        self.created = created
        self.userId = userId
        self.childreanOrDependents = childreanOrDependents
        self.contactInfo = contactInfo
        self.financialData = financialData
        self.personalInfo = personalInfo

    }
    
    //Company
    init(createdAt: Date?, userId: String?, contactInfo: ContactInfo?, personalInfo: PersonalInfo?, keyMen: [KeyMen]? ) {
        self.created = createdAt
        self.userId = userId
        self.contactInfo = contactInfo
        self.personalInfo = personalInfo
        self.keyMen = keyMen
    }
    
}

class MeetingData : Equatable {
    var date: Date?
    var endtime: Date?
    var location: String?
    var meetingTitle: String?
    var presenation: String?
    var starttime: Date?
    var userId : String?
    var userName: String?
    var meetingId: String?
    var formType: Int16?

    init(date: Date?, endTime: Date?, location: String?, meetingTitle: String?, presentation: String?, starttime: Date?, userId: String?, userName: String?, meetingId: String?,formType: Int16?) {
        self.date = date
        self.endtime = endTime
        self.location = location
        self.meetingTitle = meetingTitle
        self.presenation = presentation
        self.starttime = starttime
        self.userId = userId
        self.userName = userName
        self.meetingId = meetingId
        self.formType = formType
    }
   
    static func == (lhs: MeetingData, rhs: MeetingData) -> Bool {
        return lhs.userId == rhs.userId
    }
}

class ContactsNumbers {
    var contactType: String?
    var contactNumber: String?
    
    init(contactNumber: String, contactType: String) {
        self.contactType = contactType
        self.contactNumber = contactNumber
    }
}
