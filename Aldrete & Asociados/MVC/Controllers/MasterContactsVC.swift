//
//  MasterContactsVC.swift
//  Aldrete & Asociados
//
//  Created by Sandeep Kumar on 23/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit
import CoreData

class MasterContactsVC: BaseVC {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnTopHeader: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerXIBForHeaderFooter(MasterSection.identfier)
            tableView.registerXIB(FilterCell.identfier)
            tableView.registerXIB(ContactCell.identfier)
        }
    }
    //MARK:- Properties
    private var dataSource: TableDataSource<MasterContactsModel>?
    private var items: [MasterContactsModel]?
    var didTapContact: ((_ data: ProfileFullData?) -> Void)?
    var companyFormCD : [CompanyFormCD] = []
    var personFormCD : [PersonFormCD] = []
    var formType: FormType = .Company
    var personModels = [ProfileFullData]()
    var companyModels = [ProfileFullData]()
    var filterModels = [ProfileFullData]()
     var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add the Notification when the user delete the contact from the database.
        NotificationCenter.default.addObserver(self, selector: #selector(reloadContacts(notification:)), name: Notification.Name("ReloadContactWhenDelete"), object: nil)
        
        searchBar.delegate = self
        searchBar.returnKeyType = .search
        items = MasterContactsModel.getSectionalData()
        dataSource = TableDataSource<MasterContactsModel>(TableType.MultipleSection(items: items ?? []), tableView, false)
        dataSource?.configureHeaderFooter = { (section, item, view, isHeader) in
            (view as? MasterSection)?.item = item
        }
        
        dataSource?.configureCell = { (cell, item, indexPath, property) in
            switch /property?.cellIdentifier {
            case FilterCell.identfier:
                (cell as? FilterCell)?.item = item
                (cell as? FilterCell)?.moreBtn.tag = indexPath.row
                (cell as? FilterCell)?.didTapAdd = { [weak self] (sender) in
                    let controller = ArrayChoiceTableViewController(VCLiteral.allStatusValues) { (index) in
                        if  index.rawValue ==  VCLiteral.ALL.rawValue {
                            //All
                              self?.fetchWithCompanySatus(status: VCLiteral.ALL.localized)
//                            if self?.formType == .Company {
//                                self?.fetchWithCompanySatus(status: VCLiteral.ALL.localized)
//                            } else if self?.formType == .Person {
//                                self?.fetchWithPersonalSatus(status: VCLiteral.ALL.localized)
//                            }

                        } else if  index.rawValue ==  VCLiteral.WARM.rawValue {
                            //WARM
                            
                            if self?.formType == .Company {
                                self?.fetchWithCompanySatus(status: VCLiteral.WARM.localized)
                            } else if self?.formType == .Person {
                                self?.fetchWithPersonalSatus(status: VCLiteral.WARM.localized)
                            }
                            
                        } else if  index.rawValue ==  VCLiteral.HOT.rawValue {
                            //HOT
                            
                            if self?.formType == .Company {
                                self?.fetchWithCompanySatus(status: VCLiteral.HOT.localized)
                            } else if self?.formType == .Person {
                                self?.fetchWithPersonalSatus(status: VCLiteral.HOT.localized)
                            }
                            
                        } else if  index.rawValue ==  VCLiteral.COLD.rawValue {
                            //COLD
                            
                            if self?.formType == .Company {
                                self?.fetchWithCompanySatus(status: VCLiteral.COLD.localized)
                            } else if self?.formType == .Person {
                                self?.fetchWithPersonalSatus(status: VCLiteral.COLD.localized)
                            }

                        }
                    }
                    
                    controller.preferredContentSize = CGSize(width: 300, height: 200)
                    self?.showPopup(controller, sourceView: sender)
                }
                (cell as? FilterCell)?.selectDate = { [weak self] (sender) in
                    
                    self?.datePicker(datePickerMode: .date, textField: sender)
                }
            
                
            case ContactCell.identfier:
                (cell as? ContactCell)?.item = item
            default:
                break
            }
        }
        
        
        dataSource?.didSelectRow = { [weak self] (indexPath, item, property) in
            
            switch /property?.cellIdentifier {
            case ContactCell.identfier: //Section 1
                self?.didTapContact?((item as? ProfileFullData))
//            case FilterCell.identfier: //Section 0
            
                
//                guard let splitVC = self?.navigationController?.viewControllers.first(where: {$0.isKind(of: SplitVC.self)}) as? SplitVC else {
//                    return
//                }
//                (splitVC.viewControllers.last as? UINavigationController)?.viewControllers.last?.popVC()
                
                
            default: break
            }
        }
    }
    
    
    private func showPopup(_ controller: UIViewController, sourceView: UIView) {
        let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
        presentationController.sourceView = sourceView
        presentationController.sourceRect = sourceView.bounds
        presentationController.permittedArrowDirections = [.up]
        self.present(controller, animated: true)
    }
    
    @objc private func reloadContacts(notification: NSNotification){
        //do stuff using the userInfo property of the notification object
        if formType == .Company {
            fetchCompanyCoreDataObjects()
        } else if formType == .Person {
            fetchPersonCoreDataObjects()
        } else if formType == .Conference {
            return
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if formType == .Company {
            fetchCompanyCoreDataObjects()
        } else if formType == .Person {
            fetchPersonCoreDataObjects()
        } else if formType == .Conference {
            return
        }
        
    }
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        formType = FormType(rawValue: sender.selectedSegmentIndex) ?? .Company
        
        if formType == .Conference {
            return
        } else if formType == .Company {
            Validate.shared.type = .Company
            NotificationCenter.default.post(name: Notification.Name("backToHome"), object: nil)
            NotificationCenter.default.post(name: Notification.Name("UpdateData"), object: nil)
            fetchCompanyCoreDataObjects()
            
        } else if formType == .Person {
            Validate.shared.type = .Person
            NotificationCenter.default.post(name: Notification.Name("backToHome"), object: nil)
            NotificationCenter.default.post(name: Notification.Name("UpdateData"), object: nil)
            fetchPersonCoreDataObjects()
           
        }
    }
    
    
    
    @IBAction func btnTopHeaderAction(_ sender: UIButton) {
        let destVC = StoryboardScene.Main.FormVC.instantiate()
        destVC.formType = formType
        pushVC(destVC)
    }
}

extension MasterContactsVC : UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            if formType == .Company {
                filterModels = companyModels
            } else if formType == .Person {
                filterModels = personModels
            }
        } else {
            // Filter the results
            
            if formType == .Company {
                filterModels = companyModels.filter { $0.contactInfo?.fullName?.lowercased().contains(searchText.lowercased()) ?? false }
            } else if formType == .Person {
                filterModels = personModels.filter { $0.contactInfo?.fullName?.lowercased().contains(searchText.lowercased()) ?? false }
            }
            
        }
        
        self.items?.last?.items = filterModels
        self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items ?? []), .FullReload)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        searchBar.text = ""
        
        if formType == .Company {
            filterModels = companyModels
        } else if formType == .Person {
          filterModels = personModels
        }
        self.items?.last?.items = filterModels
        self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items ?? []), .FullReload)
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}



//MARK: Fetch
extension MasterContactsVC {
        func fetchCompanyCoreDataObjects() {
        
        //get the keyMen with userId
        CoreDataHelper.shared.fetch(entityName: EntityName.CompanyFormCD) { (values, success) in
            if success {
                
                let companyFormCD = values as! [CompanyFormCD]
                companyModels.removeAll()
                
                var keyMenModelsArray = [KeyMen]()
                for companyData in companyFormCD {
                    keyMenModelsArray.removeAll()
                    for keyMen in companyData.keyMen ?? [] {
                        let keyMenData = keyMen as? KeyMenCD
                        keyMenModelsArray.append(KeyMen(defferedCompensation: keyMenData?.defferedCompensation,
                                                        dob: keyMenData?.dob,
                                                        fullName: keyMenData?.fullName,
                                                        prizeAmount: keyMenData?.prizeAmount,
                                                        sharePercentage: keyMenData?.sharePercentageMember,
                                                        smoke: keyMenData?.smoke))
                    }
                    
                    
                    companyModels.append(ProfileFullData(createdAt: companyData.created,
                                                         userId: companyData.userId,
                                                         contactInfo: ContactInfo(email: companyData.contactInfo?.email,
                                                                                  formType: companyData.contactInfo?.formType,
                                                                                  fullName: companyData.contactInfo?.fullName,
                                                                                  userId: companyData.contactInfo?.userId,
                                                                                  whatsAppNumber: companyData.contactInfo?.whatsAppNo,
                                                                                  notes: companyData.contactInfo?.notes, dateofMeetingOfProposal: companyData.contactInfo?.dateOfMeetingProposal, status: companyData.contactInfo?.status),
                                                         
                                                         personalInfo: PersonalInfo(dob: companyData.personalInfo?.dob,
                                                                                    formType: companyData.personalInfo?.formType,
                                                                                    smoke: companyData.personalInfo?.smoke,
                                                                                    spouseName: companyData.personalInfo?.spouseName,
                                                                                    userId: companyData.personalInfo?.userId),
                                                         keyMen: keyMenModelsArray))
                }
                
                Validate.shared.profileFullData = companyModels
                self.items?.last?.items = companyModels
                self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items ?? []), .FullReload)
                
            } else {
                print("Could not be fetch data from local database.")
            }
        }
        
    }
   
    
    
    
    func fetchPersonCoreDataObjects() {
        
        CoreDataHelper.shared.fetch(entityName: EntityName.PersonalInfo) { (values, success) in
            if success {
                
                
                let personFormCD = values as! [PersonFormCD]
                var childrenModelsArray = [ChilderenOrDependents]()
                personModels.removeAll()
                
                for personData in personFormCD {
                    
                    childrenModelsArray.removeAll()
                    for children in personData.childreanOrDependents ?? [] {
                        let childrenData = children as? ChildrenOrDependentsCD
                        
                        childrenModelsArray.append(ChilderenOrDependents(dob: childrenData?.dob,
                                                                         fullName: childrenData?.fullName,
                                                                         id: childrenData?.id,
                                                                         userId: childrenData?.id))
                    }
                    
                    //Need to check...
                    if personData.contactInfo?.email != nil &&  personData.contactInfo?.email != "" {
                        personModels.append(ProfileFullData(
                            created: personData.created,
                            userId: personData.userId,
                            childreanOrDependents: childrenModelsArray,
                            
                            contactInfo: ContactInfo(email: personData.contactInfo?.email,
                                                     formType: personData.contactInfo?.formType,
                                                     fullName: personData.contactInfo?.fullName,
                                                     userId: personData.contactInfo?.userId,
                                                     whatsAppNumber: personData.contactInfo?.whatsAppNo,
                                                     notes: personData.contactInfo?.notes, dateofMeetingOfProposal: personData.contactInfo?.dateOfMeetingProposal, status: personData.contactInfo?.status),
                            
                            financialData: FinancialModel(company: personData.financialData?.company,
                                                          contingencyPlan: personData.financialData?.contingencyPlan,
                                                          doingToReachThem: personData.financialData?.doingToReachThem,
                                                          financialGoals: personData.financialData?.financialGoals,
                                                          howMuchMoney: personData.financialData?.howMuchMoney,
                                                          instrument: personData.financialData?.instrument,
                                                          isContigencyPlan: personData.financialData?.isContigencyPlan,
                                                          isDebt: personData.financialData?.isDebt,
                                                          isGMM_Insurance: personData.financialData?.isGMM_Insurance,
                                                          isMoneySaved: personData.financialData?.isMoneySaved,
                                                          isWill: personData.financialData?.isWill,
                                                          monthlyFixedCost: personData.financialData?.monthlyFixedCost,
                                                          nominee: personData.financialData?.nominee,
                                                          percentageCoveringExpensesElla: personData.financialData?.percentageCoveringExpensesElla,
                                                          percentageThatCoverExpenses: personData.financialData?.percentageThatCoverExpenses,
                                                          presentProposalDate: personData.financialData?.presentProposalDate,
                                                          retireAge: personData.financialData?.retireAge,
                                                          sumSecuredMXN: personData.financialData?.sumSecuredMXN,
                                                          userId: personData.financialData?.userId,
                                                          whatDebts: personData.financialData?.whatDebts,
                                                          isRetirementPlan: personData.financialData?.isFinanacialPlanOfRetirement,
                                                          whatRetireMentPlan: personData.financialData?.retirementPlan,
                                                          dateOfMeeting: personData.financialData?.presentProposalDate,
                                                          fimilyLeaveRequirement: personData.financialData?.howManyYearForFamily, monthlyVariableExpenses: personData.financialData?.monthlyVariableExpenses, doYouhaveSpouse: personData.financialData?.doYouhaveSpouse, retirement: personData.financialData?.retirement, mortgagePayment: personData.financialData?.mortgagePayment, insured: personData.financialData?.insured, moneyNeedByFamily: personData.financialData?.moneyNeedByFamily, protection: personData.financialData?.protection),
                            
                            personalInfo: PersonalInfo(dob: personData.personalInfo?.dob,
                                                       formType: personData.personalInfo?.formType,
                                                       smoke: personData.personalInfo?.smoke,
                                                       spouseName: personData.personalInfo?.spouseName,
                                                       userId: personData.personalInfo?.userId))
                        )
                    }
                    
             
                    
                    
                }
                Validate.shared.profileFullData = personModels
                self.items?.last?.items = personModels
                
                
                self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items ?? []), .FullReload)
                
            }
        }
    }
    
    
    
    func fetchWithCompanySatus(status: String) {
      
//        if status == VCLiteral.ALL.localized {
//            self.items?.last?.items = companyModels
//            self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items ?? []), .FullReload)
//
//        } else {
        
        if status == VCLiteral.ALL.localized {
            filterModels = companyModels
        }
        else {
            filterModels = companyModels.filter { $0.contactInfo?.status?.contains(status) ?? false }
        }
        
        
            
            self.items?.last?.items = filterModels
            self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items ?? []), .FullReload)
            
        //}
        
    }
    
    func fetchWithPersonalSatus(status: String) {
        
//        if status == VCLiteral.ALL.localized {
//            self.items?.last?.items = personModels
//            self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items ?? []), .FullReload)
//
//        } else {
        
            filterModels = personModels.filter { $0.contactInfo?.status?.contains(status) ?? false }
            
            self.items?.last?.items = personModels
            self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items ?? []), .FullReload)
            
        //}
    }
    
}
extension MasterContactsVC {
    
    func datePicker(datePickerMode: UIDatePicker.Mode, textField: UITextField) {
        
        let customView:UIView = UIView (frame: CGRect(x: 0, y: 100, width: 320, height: 160))
        customView.backgroundColor = .white
        datePicker = UIDatePicker(frame: CGRect(x: (self.view.bounds.size.width) , y: 0, width: 320, height: 160))
        datePicker.datePickerMode = datePickerMode
        customView.addSubview(datePicker)
        textField.inputView = customView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = Colors.APP_THEME.uiColor
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(datePickerSelected))
        let resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetDateFiterData))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([resetButton,spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    
    @objc func datePickerSelected() {
        
        let dataDict:[String: String] = ["selectedDate": datePicker.date.string(format: "dd/MM/yyyy")]
        
        print(dataDict)
        NotificationCenter.default.post(name: Notification.Name("filterArrayAccordingToDate"), object: nil, userInfo: dataDict)
        
        self.view.endEditing(true)
    }
    
    @objc func resetDateFiterData() {
        NotificationCenter.default.post(name: Notification.Name("resetDate"), object: nil)
        self.view.endEditing(true)
    }
}
