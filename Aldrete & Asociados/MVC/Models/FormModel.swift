//
//  FormModel.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 28/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

enum FormType: Int {
  case Company = 0
  case Person = 1
  case Conference = 2
  
  var title: VCLiteral {
    switch self {
    case .Company:
      return .FORM_COMPANY_TITLE
    case .Person:
      return .FORM_PERSONAL_TITLE
    case .Conference:
      return .FORM_CONFERENCE_TITLE
    }
  }
  
  var image: UIImage {
    switch self {
    case .Company:
      return #imageLiteral(resourceName: "ic_Conference")
    case .Person:
      return #imageLiteral(resourceName: "ic_personal")
    case .Conference:
      return #imageLiteral(resourceName: "ic_Conference")
    }
  }
}

class FormModel: HeaderFooterDataProvider {
  var property: HeaderFooterValues?
   
  var items: [Any]?
  
  var other: OtherHeaderFooterProperty?
  
    var tf1Value: Any?
    var tf2Value: Any?
    var tf3Value: Any?
    var tf4Value: Any?
    var tf5Value: Any?
    var tf6Value: Any?
    
  required init(_property: HeaderFooterValues?, _items: [Any]?, _other: OtherHeaderFooterProperty?) {
    property = _property
    items = _items
    other = _other
  }
}

extension FormModel {
    
    
    class func getSectionWiseDataForEdit(for form: FormType, profileFullData: ProfileFullData?) -> [FormModel] {
        
        
        var personalCellField = [FormTextField]()
        for childrenDependant in profileFullData?.childreanOrDependents ?? [] {
            
            let fullName = childrenDependant.fullName
            let dob = childrenDependant.dob?.dateToString(format: "dd/MM/yyyy")
            
            
            personalCellField.append(FormTextField(2, true, [
                FieldData.init(.CF_SEC_CONTACT_INFO_F1, fullName, .default, false, false),
                FieldData.init(.CF_SEC_PERSONAL_INFO_F1, dob, .default, false, false),
                ])
            )
        }
        
        //Personal Information
        let peronal_dob = profileFullData?.personalInfo?.dob?.dateToString(format: "dd/MM/yyyy")
        let personal_smoke = profileFullData?.personalInfo?.smoke ?? false ? "Yes" : "No"
        let personal_spouse = profileFullData?.personalInfo?.spouseName
        
        let monthly_Fixed_Costs_$MXN = profileFullData?.financialData?.monthlyFixedCost?.intergerToString()
        let monthly_Variable_Expenses_$MXN = profileFullData?.financialData?.monthlyVariableExpenses?.intergerToString()
        let percentage_that_covers_expenses = profileFullData?.financialData?.percentageThatCoverExpenses?.intergerToString()
        
        let percentage_covering_expenses_Ella = profileFullData?.financialData?.percentageCoveringExpensesElla?.intergerToString()
        let GMM_insurance = profileFullData?.financialData?.isGMM_Insurance ?? false ? "Yes" : "No"
        let company = profileFullData?.financialData?.company
        
        let sum_Secured_$MXN = profileFullData?.financialData?.sumSecuredMXN?.intergerToString()
        let will = profileFullData?.financialData?.isWill ?? false ? "Yes" : "No"
        let have_Debt = profileFullData?.financialData?.isDebt ?? false ? "Yes" : "No"
        
        let what_debts = profileFullData?.financialData?.whatDebts
        let most_Important_Financial_Goals = profileFullData?.financialData?.financialGoals
        let what_are_you_doing_to_reach_them = profileFullData?.financialData?.doingToReachThem
        
        let have_Money_Saved = profileFullData?.financialData?.isMoneySaved ?? false ? "Yes" : "No"
        let how_much_money_$MXN = profileFullData?.financialData?.howMuchMoney?.intergerToString()
        let in_what_instrument = profileFullData?.financialData?.instrument
        
        let in_case_of_premature_death = profileFullData?.financialData?.nominee
        
        let has_a_contingency_plan_in_case_of_disability = profileFullData?.financialData?.isContigencyPlan ?? false ? "Yes" : "No"
        let what_the_plan = profileFullData?.financialData?.contingencyPlan
        
        let you_have_a_financial_plan_for_retirement = profileFullData?.financialData?.isRetirementPlan ?? false ? "Yes" : "No"
        let what_the_plan_retirement = profileFullData?.financialData?.whatRetireMentPlan
        let at_what_age_would_you_like_to_retire = profileFullData?.financialData?.retireAge?.intergerToString()
        
        let date_of_Meeting_to_Present_Proposal = profileFullData?.financialData?.dateOfMeeting?.dateToString(format: "dd/MM/yyyy")
        
        let how_many_years_do_you_want_to_leave_your_family_covered = profileFullData?.financialData?.familyLeaveRequirement
        
        let do_You_Have_Spouse = profileFullData?.financialData?.doYouhaveSpouse
        
        let retirement_Pension = profileFullData?.financialData?.retirement
        
         let mortgage_Payment = profileFullData?.financialData?.mortgagePayment
        
         let insured = profileFullData?.financialData?.insured
        
        let money_Need_By_Family = profileFullData?.financialData?.moneyNeedByFamily
        
        let protection = profileFullData?.financialData?.protection
        
        
        
        let personalFormSections = [
            
            //Contact Infromation
            FormModel( _property: HeaderFooterValues(headerIdentifier: FormSectionView.identfier,
                                                     headerHeight: Height.FormSectionView,
                                                     cellIdentifier: FormCell.identfier,
                                                     cellHeight: Height.FormCell,
                                                     footerIdentifier: "", footerHeight: 0.0001),
                       _items: [FormTextField(3, true, [FieldData.init(.PF_SECTION_CONTACT_INFORMATION_F1, profileFullData?.contactInfo?.fullName, .namePhonePad, false, false),
                                                        FieldData.init(.PF_SECTION_CONTACT_INFORMATION_F2, profileFullData?.contactInfo?.email, .emailAddress, false, false),
                                                        FieldData.init(.PF_SECTION_CONTACT_INFORMATION_F3, profileFullData?.contactInfo?.whatsAppNumber, .decimalPad, false, false)])],
                       
                       _other: OtherHeaderFooterProperty(title: VCLiteral.PF_SECTION_CONTACT_INFORMATION.localized,
                                                         subTitle: "",
                                                         isBtnVisible: false,
                                                         image: UIImage(),
                                                         btnName: "")
            ),
            
            //Personal Information.
            FormModel( _property: HeaderFooterValues(headerIdentifier: FormSectionView.identfier,
                                                     headerHeight: Height.FormSectionView,
                                                     cellIdentifier: FormCell.identfier,
                                                     cellHeight: Height.FormCell,
                                                     footerIdentifier: "",
                                                     footerHeight: 0.0001),
                       
                       _items: [FormTextField(3, true, [FieldData.init(.PF_SECTION_PERSONAL_INFORMATION_F1, peronal_dob, .default, false, false),
                                                        FieldData.init(.PF_SECTION_PERSONAL_INFORMATION_F2, personal_smoke, .default, false, false),
                                                        FieldData.init(.PF_SECTION_PERSONAL_INFORMATION_F3, personal_spouse, .default, false, false)])],
                       _other: OtherHeaderFooterProperty(title: VCLiteral.PF_SECTION_PERSONAL_INFORMATION.localized,
                                                         subTitle: "",
                                                         isBtnVisible: false,
                                                         image: UIImage(),
                                                         btnName: "")),
            
            //Children Dependent
            FormModel( _property: HeaderFooterValues(headerIdentifier: AddChildDependentSectionView.identfier,
                                                     headerHeight: Height.AddChildDependentSectionView,
                                                     cellIdentifier: ChildDependentCell.identfier,
                                                     cellHeight: Height.ChildDependentCell,
                                                     footerIdentifier: "",
                                                     footerHeight: 0.0001),
                       
                       _items: personalCellField,
                       
                       _other: OtherHeaderFooterProperty(title: VCLiteral.PF_SECTION_CHILDREN_DEPENDENTS.localized,
                                                         subTitle: "",
                                                         isBtnVisible: true,
                                                         image: #imageLiteral(resourceName: "ic_blue_add"),
                                                         btnName: VCLiteral.PF_SECTION_CHILDREN_DEPENDENTS_ADD_TITLE.localized)),
            
            
            //Financial Data.
            FormModel( _property: HeaderFooterValues(headerIdentifier: FormSectionView.identfier,
                                                     headerHeight: Height.FormSectionView,
                                                     cellIdentifier: FormCell.identfier,
                                                     cellHeight: Height.FormCell,
                                                     footerIdentifier: "",
                                                     footerHeight: 0.0001),
                       
                       _items: [FormTextField(3, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F01, monthly_Fixed_Costs_$MXN, .numberPad, false, false),
                                                        FieldData.init(.PF_SECTION_FINANCIAL_DATA_F02, monthly_Variable_Expenses_$MXN, .numberPad, false, false),
                                                        FieldData.init(.PF_SECTION_FINANCIAL_DATA_F03, percentage_that_covers_expenses, .numberPad, false, false)]),
                                
                                FormTextField(2, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F04, percentage_covering_expenses_Ella, .numberPad, false, false),
                                                        FieldData.init(.PF_SECTION_FINANCIAL_DATA_F05, GMM_insurance, .default, false, false)]),
                                
                                FormTextField(3, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F06, company, .default, false, false),FieldData.init(.PF_SECTION_FINANCIAL_DATA_F07, sum_Secured_$MXN, .numberPad, false, false),
                                                        FieldData.init(.PF_SECTION_FINANCIAL_DATA_F08, will, .default, false, false)]),
                                
                                FormTextField(2, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F09, have_Debt, .default, false, false),FieldData.init(.PF_SECTION_FINANCIAL_DATA_F10, what_debts, .default, false, false)]),
                                
                                FormTextField(3, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F11, most_Important_Financial_Goals, .default, true, false), // act as button
                                    FieldData.init(.PF_SECTION_FINANCIAL_DATA_F12, what_are_you_doing_to_reach_them, .default, false, false),
                                    FieldData.init(.PF_SECTION_FINANCIAL_DATA_F13, have_Money_Saved, .default, false, false)]),
                                FormTextField(2, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F14, how_much_money_$MXN, .numberPad, false, false),
                                                         FieldData.init(.PF_SECTION_FINANCIAL_DATA_F15, in_what_instrument, .default, false, false)]),
                                
                                FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F16, in_case_of_premature_death, .default, false, false)]),
                                
                                FormTextField(2, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F17, has_a_contingency_plan_in_case_of_disability, .default, false, false),
                                                        FieldData.init(.PF_SECTION_FINANCIAL_DATA_F18, what_the_plan, .default, false, false)]),
                                
                                FormTextField(2, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F19, you_have_a_financial_plan_for_retirement, .default, false, false),
                                                        FieldData.init(.PF_SECTION_FINANCIAL_DATA_F20, what_the_plan_retirement, .default, false, false)]),
                                
                                FormTextField(2, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F21, at_what_age_would_you_like_to_retire, .default, false, false),FieldData.init(.PF_SECTION_FINANCIAL_DATA_F22, date_of_Meeting_to_Present_Proposal, .default, false, false)]),
                                
                                FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F23, how_many_years_do_you_want_to_leave_your_family_covered, .default, false, false)]),
                                
                                FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F24, do_You_Have_Spouse, .default, false, false)]),
                                
                                FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F25, retirement_Pension, .default, false, false)]),
                                
                                FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F26, mortgage_Payment, .default, false, false)]),
        
                                FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F27, insured, .default, false, false)]),
                                
                                FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F28, money_Need_By_Family, .default, false, false)]),
     
                                FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F29, protection, .default, false, false)]),
                   ],
                       
                       
                       
                       _other: OtherHeaderFooterProperty(title: VCLiteral.PF_SECTION_FINANCIAL_DATA.localized,
                                                         subTitle: "",
                                                         isBtnVisible: false,
                                                         image: UIImage(),
                                                         btnName: ""))]
        
        
        
        var keymenCellField = [FormTextField]()
        for keyMen in profileFullData?.keyMen ?? [] {
            
            let sharePercentage = keyMen.sharePercentage
            let smokeValue = keyMen.smoke ?? false ? "Yes" : "No"
            let prizeAmount = keyMen.prizeAmount
            let fullname = keyMen.fullName
            let dob = keyMen.dob
            let defferedCompensation = keyMen.defferedCompensation
            
            
            keymenCellField.append(FormTextField(6, true, [
                FieldData.init(.CF_SEC_CONTACT_INFO_F1, fullname, .default, false, false),
                FieldData.init(.CF_SEC_PERSONAL_INFO_F1, dob?.dateToString(format: "dd/MM/yyyy"), .default, false, false),
                FieldData.init(.CF_SEC_KEY_MEN_F3, sharePercentage?.intergerToString(), .default, false, false),
                FieldData.init(.CF_SEC_KEY_MEN_F4, smokeValue, .default, false, false),
                FieldData.init(.CF_SEC_KEY_MEN_F5, prizeAmount?.intergerToString(), .default, false, false),
                FieldData.init(.CF_SEC_KEY_MEN_F6, defferedCompensation, .default, false, false)
                ]))
        }
        
        
        let companyFormSections = [
            
            //Contact Information
            FormModel.init(_property: HeaderFooterValues(headerIdentifier: FormSectionView.identfier,
                                                         headerHeight: Height.FormSectionView,
                                                         cellIdentifier: FormCell.identfier,
                                                         cellHeight: Height.FormCell,
                                                         footerIdentifier: "",
                                                         footerHeight: 0.0001),
                           
                           _items: [FormTextField.init(3, true, [FieldData.init(.CF_SEC_CONTACT_INFO_F1, profileFullData?.contactInfo?.fullName, .default, false, false),
                                                                 FieldData.init(.CF_SEC_CONTACT_INFO_F2, profileFullData?.contactInfo?.email, .emailAddress, false, false),
                                                                 FieldData.init(.CF_SEC_CONTACT_INFO_F3, profileFullData?.contactInfo?.whatsAppNumber, .numberPad, false, false)])],
                           
                           _other: OtherHeaderFooterProperty(title: VCLiteral.CF_SEC_CONTACT_INFO.localized,
                                                             subTitle: "",
                                                             isBtnVisible: false,
                                                             image: UIImage(),
                                                             btnName: "")),
            
            //Personal Information
            
            FormModel.init(_property: HeaderFooterValues(headerIdentifier: FormSectionView.identfier,
                                                         headerHeight: Height.FormSectionView,
                                                         cellIdentifier: FormCell.identfier,
                                                         cellHeight: Height.FormCell,
                                                         footerIdentifier: "",
                                                         footerHeight: 0.0001),
                           
                           _items: [FormTextField.init(2, false, [FieldData.init(.CF_SEC_PERSONAL_INFO_F1, profileFullData?.personalInfo?.dob?.dateToString(format: "dd/MM/yyyy"), .default, false, false),
                                                                  FieldData.init(.CF_SEC_PERSONAL_INFO_F2, profileFullData?.personalInfo?.smoke ?? false ? "Yes" : "No", .default, false, false)])],
                           
                           _other: OtherHeaderFooterProperty(title: VCLiteral.CF_SEC_PERSONAL_INFO.localized,
                                                             subTitle: "",
                                                             isBtnVisible: false,
                                                             image: UIImage(),
                                                             btnName: "")),
            
            
            //Keymen
            FormModel.init(_property: HeaderFooterValues(headerIdentifier: KeyMenChildDependentSectionView.identfier,
                                                         headerHeight: Height.KeyMenChildDependentSectionView,
                                                         cellIdentifier: KeymenChildDependentCell.identfier,
                                                         cellHeight: Height.KeymenChildDependentCell,
                                                         footerIdentifier: "",
                                                         footerHeight: 0.0001),
                           _items: keymenCellField,
                           _other: OtherHeaderFooterProperty(title: VCLiteral.CF_SEC_KEY_MEN.localized,
                                                             subTitle: "",
                                                             isBtnVisible: false,
                                                             image: UIImage(),
                                                             btnName: "")),
            
            
            //Date of Meeting
            FormModel.init(_property: HeaderFooterValues(headerIdentifier: "",
                                                         headerHeight: 0.0001,
                                                         cellIdentifier: FormCell.identfier,
                                                         cellHeight: Height.FormCell,
                                                         footerIdentifier: "",
                                                         footerHeight: 0.0001),
                           _items: [FormTextField.init(1, false, [FieldData.init(.CF_SEC_DATE_OF_MEETING_F1, profileFullData?.contactInfo?.dateofMeetingOfProposal?.dateToString(format: "dd/MM/yyyy"), .default, false, false)])],
                           _other: nil)]
        
        
        switch form {
            
        case .Person:
            return personalFormSections
            
        case .Company:
            return companyFormSections
            
        case .Conference:
            return []
            
        }
        
    }
    
    
    class func getSectionWiseData(for form: FormType) -> [FormModel] {
        //Personal form
        let personalFormSections = [
            
            //Contact Infromation
            FormModel( _property: HeaderFooterValues(headerIdentifier: FormSectionView.identfier,
                                                     headerHeight: Height.FormSectionView,
                                                     cellIdentifier: FormCell.identfier,
                                                     cellHeight: Height.FormCell,
                                                     footerIdentifier: "", footerHeight: 0.0001),
                       _items: [FormTextField(3, true, [FieldData.init(.PF_SECTION_CONTACT_INFORMATION_F1, nil, .namePhonePad, false, false),
                                                        FieldData.init(.PF_SECTION_CONTACT_INFORMATION_F2, nil, .emailAddress, false, false),
                                                        FieldData.init(.PF_SECTION_CONTACT_INFORMATION_F3, nil, .decimalPad, false, false)])],
                       
                       _other: OtherHeaderFooterProperty(title: VCLiteral.PF_SECTION_CONTACT_INFORMATION.localized,
                                                         subTitle: "",
                                                         isBtnVisible: false,
                                                         image: UIImage(),
                                                         btnName: "")
            ),
            
            //Personal Information.
            FormModel( _property: HeaderFooterValues(headerIdentifier: FormSectionView.identfier,
                                                     headerHeight: Height.FormSectionView,
                                                     cellIdentifier: FormCell.identfier,
                                                     cellHeight: Height.FormCell,
                                                     footerIdentifier: "",
                                                     footerHeight: 0.0001),
                       
                       _items: [FormTextField(3, true, [FieldData.init(.PF_SECTION_PERSONAL_INFORMATION_F1, nil, .default, false, false),
                                                        FieldData.init(.PF_SECTION_PERSONAL_INFORMATION_F2, nil, .default, false, false),
                                                        FieldData.init(.PF_SECTION_PERSONAL_INFORMATION_F3, nil, .namePhonePad, false, false)])],
                       _other: OtherHeaderFooterProperty(title: VCLiteral.PF_SECTION_PERSONAL_INFORMATION.localized,
                                                         subTitle: "",
                                                         isBtnVisible: false,
                                                         image: UIImage(),
                                                         btnName: "")),
            
            //Children Dependent
            FormModel( _property: HeaderFooterValues(headerIdentifier: AddChildDependentSectionView.identfier,
                                                     headerHeight: Height.AddChildDependentSectionView,
                                                     cellIdentifier: ChildDependentCell.identfier,
                                                     cellHeight: Height.ChildDependentCell,
                                                     footerIdentifier: "",
                                                     footerHeight: 0.0001),
                       
                       _items: [],
                       
                       _other: OtherHeaderFooterProperty(title: VCLiteral.PF_SECTION_CHILDREN_DEPENDENTS.localized,
                                                         subTitle: "",
                                                         isBtnVisible: true,
                                                         image: #imageLiteral(resourceName: "ic_blue_add"),
                                                         btnName: VCLiteral.PF_SECTION_CHILDREN_DEPENDENTS_ADD_TITLE.localized)),
            
            
            //Financial Data.
            FormModel( _property: HeaderFooterValues(headerIdentifier: FormSectionView.identfier,
                                                     headerHeight: Height.FormSectionView,
                                                     cellIdentifier: FormCell.identfier,
                                                     cellHeight: Height.FormCell,
                                                     footerIdentifier: "",
                                                     footerHeight: 0.0001),
                       
                       _items: [FormTextField(3, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F01, nil, .numberPad, false, false),
                                                        FieldData.init(.PF_SECTION_FINANCIAL_DATA_F02, nil, .numberPad, false, false),
                                                        FieldData.init(.PF_SECTION_FINANCIAL_DATA_F03, nil, .numberPad, false, false)]),
                                
                                FormTextField(2, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F04, nil, .numberPad, false, false),
                                                        FieldData.init(.PF_SECTION_FINANCIAL_DATA_F05, nil, .default, false, false)]),
                                
                                FormTextField(3, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F06, nil, .default, false, false),FieldData.init(.PF_SECTION_FINANCIAL_DATA_F07, nil, .numberPad, false, false),
                                                        FieldData.init(.PF_SECTION_FINANCIAL_DATA_F08, nil, .default, false, false)]),
                                
                                FormTextField(2, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F09, nil, .default, false, false),FieldData.init(.PF_SECTION_FINANCIAL_DATA_F10, nil, .default, false, false)]),
                                
                                FormTextField(3, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F11, nil, .default, true, false), // act as button
                                    FieldData.init(.PF_SECTION_FINANCIAL_DATA_F12, nil, .default, false, false),
                                    FieldData.init(.PF_SECTION_FINANCIAL_DATA_F13, nil, .default, false, false)]),
                                FormTextField(2, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F14, nil, .numberPad, false, false),
                                                         FieldData.init(.PF_SECTION_FINANCIAL_DATA_F15, nil, .default, false, false)]),
                                
                                FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F16, nil, .default, false, false)]),
                                
                                FormTextField(2, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F17, nil, .default, false, false),
                                                        FieldData.init(.PF_SECTION_FINANCIAL_DATA_F18, nil, .default, false, false)]),
                                
                                FormTextField(2, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F19, nil, .default, false, false),
                                                        FieldData.init(.PF_SECTION_FINANCIAL_DATA_F20, nil, .default, false, false)]),
                                
                                FormTextField(2, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F21, nil, .default, false, false),FieldData.init(.PF_SECTION_FINANCIAL_DATA_F22, nil, .default, false, false)]),
                                
                                 FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F23, nil, .default, false, false)]),
                                
                                 FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F24, nil, .default, false, false)]),
                                
                                FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F25, nil, .default, false, false)]),
                        
                               FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F26, nil, .default, false, false)]),
                               
                                FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F27, nil, .default, false, false)]),
                               
                            FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F28, nil, .default, false, false)]),
                            
                        FormTextField(1, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F29, nil, .default, false, false)])
                        
                        
//                                FormTextField(2, true, [FieldData.init(.PF_SECTION_FINANCIAL_DATA_F23, nil, .default, false, false)],[FieldData.init(.PF_SECTION_FINANCIAL_DATA_F24, nil, .default, false, false)]),
//
                ],
                       
                       
                       
                       _other: OtherHeaderFooterProperty(title: VCLiteral.PF_SECTION_FINANCIAL_DATA.localized,
                                                         subTitle: "",
                                                         isBtnVisible: false,
                                                         image: UIImage(),
                                                         btnName: ""))]
        
        
        
        let companyFormSections = [
            
            FormModel.init(_property: HeaderFooterValues(headerIdentifier: FormSectionView.identfier,
                                                         headerHeight: Height.FormSectionView,
                                                         cellIdentifier: FormCell.identfier,
                                                         cellHeight: Height.FormCell,
                                                         footerIdentifier: "",
                                                         footerHeight: 0.0001),
                           
                           _items: [FormTextField.init(3, true, [FieldData.init(.CF_SEC_CONTACT_INFO_F1, nil, .default, false, false),
                                                                 FieldData.init(.CF_SEC_CONTACT_INFO_F2, nil, .emailAddress, false, false),
                                                                 FieldData.init(.CF_SEC_CONTACT_INFO_F3, nil, .numberPad, false, false)])],
                           
                           _other: OtherHeaderFooterProperty(title: VCLiteral.CF_SEC_CONTACT_INFO.localized,
                                                             subTitle: "",
                                                             isBtnVisible: false,
                                                             image: UIImage(),
                                                             btnName: "")),
            
            FormModel.init(_property: HeaderFooterValues(headerIdentifier: FormSectionView.identfier,
                                                         headerHeight: Height.FormSectionView,
                                                         cellIdentifier: FormCell.identfier,
                                                         cellHeight: Height.FormCell,
                                                         footerIdentifier: "",
                                                         footerHeight: 0.0001),
                           
                           _items: [FormTextField.init(2, true, [FieldData.init(.CF_SEC_PERSONAL_INFO_F1, nil, .default, false, false),
                                                                  FieldData.init(.CF_SEC_PERSONAL_INFO_F2, nil, .default, false, false)])],
                           
                           _other: OtherHeaderFooterProperty(title: VCLiteral.CF_SEC_PERSONAL_INFO.localized,
                                                             subTitle: "",
                                                             isBtnVisible: false,
                                                             image: UIImage(),
                                                             btnName: "")),
            
            
            FormModel.init(_property: HeaderFooterValues(headerIdentifier: KeyMenChildDependentSectionView.identfier,
                                                         headerHeight: Height.KeyMenChildDependentSectionView,
                                                         cellIdentifier: KeymenChildDependentCell.identfier,
                                                         cellHeight: Height.KeymenChildDependentCell,
                                                         footerIdentifier: "",
                                                         footerHeight: 0.0001),
                           _items: [],
                           _other: OtherHeaderFooterProperty(title: VCLiteral.CF_SEC_KEY_MEN.localized,
                                                             subTitle: "",
                                                             isBtnVisible: false,
                                                             image: UIImage(),
                                                             btnName: "")),
            
            FormModel.init(_property: HeaderFooterValues(headerIdentifier: "",
                                                         headerHeight: 0.0001,
                                                         cellIdentifier: FormCell.identfier,
                                                         cellHeight: Height.FormCell,
                                                         footerIdentifier: "",
                                                         footerHeight: 0.0001),
                           _items: [FormTextField.init(1, false, [FieldData.init(.CF_SEC_DATE_OF_MEETING_F1, nil, .default, false, false)])],
                           _other: nil)]
        
        switch form {
            
        case .Person:
            return personalFormSections
            
        case .Company:
            return companyFormSections
            
        case .Conference:
            return []
            
        }
    }
}


class FormTextField {
  var noOfFields: Int?
  var isEquallyDistributed: Bool?
  var fields: [FieldData]?
  
  init(_ _noOfFields: Int?, _ _isEquallyDistributed: Bool?, _ _fields: [FieldData]?) {
    noOfFields = _noOfFields
    isEquallyDistributed = _isEquallyDistributed
    fields = _fields
  }
}


class FieldData {
    
  var placeHolder: VCLiteral?
  var value: Any?
  var keyboardType: UIKeyboardType?
  var isActAsBtn: Bool?
  var isInputAccessoryUsed: Bool?
  
  init(_ _placeHolder: VCLiteral, _ _value: Any?, _ _keyboardType: UIKeyboardType?, _ _isActAsBtn: Bool?, _ _isInputAccessoryUsed: Bool?) {
    placeHolder = _placeHolder
    value = _value
    keyboardType = _keyboardType
    isActAsBtn = _isActAsBtn
    isInputAccessoryUsed = _isInputAccessoryUsed
  }
}
