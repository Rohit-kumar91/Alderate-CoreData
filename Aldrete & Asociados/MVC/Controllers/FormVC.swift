//
//  FormVC.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 27/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit


class FormVC: BaseVC {
    
    @IBOutlet weak var btnViewPPT: UIButton!
    @IBOutlet weak var btnSharePPT: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    let locale = NSLocale.current
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    var errorMessage = String()
    let phoneMaxLength = 16
    let phoneMinLength = 8
    var profileFullData = [ProfileFullData]()
    var editProfile : ProfileFullData?
    var userId =  UUID().uuidString
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerXIBForHeaderFooter(FormSectionView.identfier)
            tableView.registerXIBForHeaderFooter(FormAddFooterView.identfier)
            tableView.registerXIBForHeaderFooter(AddChildDependentSectionView.identfier)
            tableView.registerXIB(ChildDependentCell.identfier)
            tableView.registerXIB(KeymenChildDependentCell.identfier)
            tableView.registerXIB(FormCell.identfier)
            tableView.registerXIB(FormKeyMenCell.identfier)
            tableView.registerXIBForHeaderFooter(KeyMenChildDependentSectionView.identfier)
        }
    }
    
    
    @IBOutlet weak var imgDot: UIImageView!
    private var dataSource: TableDataSource<FormModel>?
    var formType: FormType = .Company
    var items: [FormModel]?
    var modelFields = ModelsFields()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        formType = Validate.shared.type
        lblDate.text = Date().string(format: "MMM d, yyyy")
        tableViewInit()
        initialSetup()
        CoreDataHelper.shared.getCompanyInfo()
        
        //(items?[0].items?.first as? FormTextField)?.fields?[0].value = "Ravinder Sharma"
        //self.dataSource?.updateAndReload(for: UpdateType.MultipleSection(items: self.items ?? []), ReloadType.FullReload)
    }
    
    
    
    @IBAction func btnAction(_ sender: UIButton) {
        switch sender.tag {
        case 0: //Back
            Validate.shared.editMain = false
            popVC()
        case 1: //View Presentation
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PresentationViewVC") as! PresentationViewVC
            self.present(vc, animated: true, completion: nil)
            
            break
        case 2: //Share Presentation
            loadPDFAndShare(sender: sender)
            break
        case 3: //Edit
            break
        case 4: //Submit
            items = dataSource?.items
            //All Validation goes here.....
            switch formType {
                
            case .Company:
                
                Validate.shared.validateCompanyTextfields(items: items) { [weak self] (errorMessage, success) in
                    if success {
                        self?.saveCompanyData()
                    } else {
                        alertWithDesc(desc: errorMessage)
                    }
                }
                break
                
            case .Person:
                Validate.shared.validatePersonTextfields(items: items) {[weak self] (errorMessage, success) in
                    if success {
                        self?.savePersonData()
                    } else {
                        alertWithDesc(desc: errorMessage)
                    }
                }
                break
                
            case .Conference:
                break
            }
            
        default:
            break
        }
    }
    
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        
        formType = FormType(rawValue: sender.selectedSegmentIndex) ?? .Company
        items = FormModel.getSectionWiseData(for: formType)
        dataSource?.updateAndReload(for: .MultipleSection(items: items ?? []), .FullReload)
        lblTitle.text = formType.title.localized
        imgDot.image = formType.image
        
        if formType == .Conference {
            return
        }
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        
        //dataSource?.updateAndReload(for: UpdateType.MultipleSection(items: items), ReloadType.FullReload)
    }
    
    //Share PDF
    func getDirectoryPath() -> String {
        let stringPath = Bundle.main.path(forResource: "App-Brewery", ofType: "pdf")
        return stringPath!
    }
    
    func loadPDFAndShare(sender : UIButton) {
        let fileManager = FileManager.default
        let documentoPath = self.getDirectoryPath()
        //(self.getDirectoryPath() as NSString).appendingPathComponent("App-Brewery.pdf")
        if fileManager.fileExists(atPath: documentoPath){
            let documento = NSData(contentsOfFile: documentoPath)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = sender
            activityViewController.popoverPresentationController?.sourceRect = sender.bounds
            present(activityViewController, animated: true, completion: nil)
        }
        else {
            print("document was not found")
        }
    }
}


//MARK:- VCFuncs
extension FormVC {
    
    func tableViewInit() {
        
        if Validate.shared.editMain {
            //Validate.shared.editMain = false
            items = FormModel.getSectionWiseDataForEdit(for: formType, profileFullData: Validate.shared.profileData)
        } else {
            items = FormModel.getSectionWiseData(for: formType)
        }
        
        dataSource = TableDataSource<FormModel>(.MultipleSection(items: items ?? []), tableView)
        dataSource?.configureHeaderFooter = { (section, item, view, isHeader) in
            
            if isHeader {
                (view as? FormSectionView)?.item = item
                (view as? AddChildDependentSectionView)?.item = item
                (view as? KeyMenChildDependentSectionView)?.item = item
                (view as? AddChildDependentSectionView)?.didTapAdd = { [weak self] (addedItem) in
                    Validate.shared.validateChildrenOrDependent(addedItem: addedItem, completion: { (errorMessage, success) in
                        if success {
                            self?.addChildDependents(addedItem: addedItem)
                        } else {
                            self?.alertWithDesc(desc: errorMessage)
                        }
                    })
                }
                
                (view as? KeyMenChildDependentSectionView)?.didTapAdd = { [weak self] (addedItem) in
                    Validate.shared.validateKeyMenOfCompanyValue(addedItem: addedItem, completion: { [weak self](errorMessage, success) in
                        if success {
                            self?.addkeyMenValues(addedItem: addedItem)
                        } else {
                            self?.view.endEditing(true)
                            self?.alertWithDesc(desc: errorMessage)
                        }
                    })
                }
                
            } else {
                (view as? FormAddFooterView)?.item = item
            }
        }
        
        dataSource?.configureCell = { [weak self] (cell, item, indexPath, property) in
            
            switch /property?.cellIdentifier {
                
            case FormCell.identfier:
                (cell as? FormCell)?.item = item
                
            case FormKeyMenCell.identfier:
                (cell as? FormKeyMenCell)?.item = item
                
            case KeymenChildDependentCell.identfier:
                (cell as? KeymenChildDependentCell)?.item = item
                
                if indexPath.row % 2 == 0 {
                    (cell as? KeymenChildDependentCell)?.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                } else {
                    (cell as? KeymenChildDependentCell)?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
                
                (cell as? KeymenChildDependentCell)?.didTapDelete = {
                    self?.deleteChildDependent(indexPath: indexPath)
                }
                
            case ChildDependentCell.identfier:
                (cell as? ChildDependentCell)?.item = item
                (cell as? ChildDependentCell)?.didTapDelete = {
                    self?.deleteChildDependent(indexPath: indexPath)
                }
                
            default:
                break
            }
        }
    }
    
    
    func addChildDependents(addedItem: FormModel?)  {
        self.items?[2].items?.append(
            FormTextField(2, true, [
                FieldData.init(.CF_SEC_CONTACT_INFO_F1, addedItem?.tf1Value, .default, false, false),
                FieldData.init(.CF_SEC_PERSONAL_INFO_F1, addedItem?.tf2Value, .default, false, false),
                ])
        )
        
        self.dataSource?.updateAndReload(for: UpdateType.MultipleSection(items: self.items ?? []), ReloadType.FullReload)
    }
    
    
    func addkeyMenValues(addedItem: FormModel?) {
        self.items?[2].items?.append(
            FormTextField(6, true, [
                FieldData.init(.CF_SEC_CONTACT_INFO_F1, addedItem?.tf1Value, .default, false, false),
                FieldData.init(.CF_SEC_PERSONAL_INFO_F1, addedItem?.tf2Value, .default, false, false),
                FieldData.init(.CF_SEC_KEY_MEN_F3, addedItem?.tf3Value, .default, false, false),
                FieldData.init(.CF_SEC_KEY_MEN_F4, addedItem?.tf4Value, .default, false, false),
                FieldData.init(.CF_SEC_KEY_MEN_F5, addedItem?.tf5Value, .default, false, false),
                FieldData.init(.CF_SEC_KEY_MEN_F6, addedItem?.tf6Value, .default, false, false)
                ])
        )
        
        self.items?[2].tf1Value = nil
        self.items?[2].tf2Value = nil
        self.items?[2].tf3Value = nil
        self.items?[2].tf4Value = nil
        self.items?[2].tf5Value = nil
        self.items?[2].tf6Value = nil
        self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items ?? []), ReloadType.ReloadSectionAt(indexSet: IndexSet.init(integer: 2), animation: .automatic))
    }
    
    
    func initialSetup() {
        lblTitle.text = formType.title.localized
        imgDot.image = formType.image
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .regular)], for: .normal)
        segmentControl.selectedSegmentIndex = formType.rawValue
    }
    
    func deleteChildDependent(indexPath: IndexPath) {
        var childs = items?[indexPath.section].items
        childs?.remove(at: indexPath.row)
        items?[indexPath.section].items = childs
        dataSource?.updateAndReload(for: .MultipleSection(items: items ?? []), .DeleteRowsAt(indexPaths: [indexPath], animation: .none))
    }
    
    func addRow(indexPath: IndexPath) {
        
    }
    
}

//MARK: Cell Textfield & KeyMen Textfield Validation And Assigning Data to the Models - Person
extension FormVC {
    
    func savePersonData() {
        
        //Adding Value to the Models
        modelFields.contact_userId = userId
        modelFields.contact_fullName = ((items?[0].items?.first as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace
        modelFields.contact_email = (items?[0].items?.first as? FormTextField)?.fields?[1].value as? String
        modelFields.contact_whatsAppNumber = (items?[0].items?.first as? FormTextField)?.fields?[2].value as? String
        
        modelFields.personal_dob = ((items?[1].items?.first as? FormTextField)?.fields?[0].value as? String)?.stringToDateWithFormat(format: "dd/MM/yyyy")
        modelFields.personal_smoke = (items?[1].items?.first as? FormTextField)?.fields?[1].value as? String == "Yes" ? true:false
        modelFields.personal_spouseName = ((items?[1].items?.first as? FormTextField)?.fields?[2].value as? String)?.trimWhiteSpace
        
        modelFields.financial_monthlyFixedCost = ((items?[3].items?.first as? FormTextField)?.fields?[0].value as? String)?.stringToInt64()
        modelFields.financial_monthlyVaraibleExpenses = ((items?[3].items?.first as? FormTextField)?.fields?[1].value as? String)?.stringToInt64()
        modelFields.financial_percentageThatCoverExpenses = ((items?[3].items?.first as? FormTextField)?.fields?[2].value as? String)?.stringToInt64()
        
        modelFields.financial_percentageCoveringExpenses = ((items?[3].items?[1] as? FormTextField)?.fields?[0].value as? String)?.stringToInt64()
        modelFields.financial_theyHaveGmmInsurance = (items?[3].items?[1] as? FormTextField)?.fields?[1].value as? String == "Yes" ? true:false
        modelFields.financial_comapny = ((items?[3].items?[2] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace
        
        modelFields.financial_sumSecuredMXN = ((items?[3].items?[2] as? FormTextField)?.fields?[1].value as? String)?.stringToInt64()
        modelFields.financial_theyWillHaveSumSecuredMXN = (items?[3].items?[2] as? FormTextField)?.fields?[2].value as? String == "Yes" ? true:false
        modelFields.financial_theyDebtSumSecuredMXN = (items?[3].items?[3] as? FormTextField)?.fields?[0].value as? String == "Yes" ? true:false
        
        modelFields.financial_whatDebts = (items?[3].items?[3] as? FormTextField)?.fields?[1].value as? String
        
        modelFields.financial_mostImportantFinancialGoals = ((items?[3].items?[4] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace
        modelFields.financial_whatAreDoingToReachThem = ((items?[3].items?[4] as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace
        modelFields.financial_haveYouSavedMoney = (items?[3].items?[4] as? FormTextField)?.fields?[2].value as? String == "Yes" ? true:false//haveSavedMoney as! String
        modelFields.financial_howMuchMoney$MNX = ((items?[3].items?[5] as? FormTextField)?.fields?[0].value as? String)?.stringToInt64()
        modelFields.financial_inWhatInstrument = ((items?[3].items?[5] as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace
        modelFields.financial_inCaseOfPrematureDeathWhoWillBeResponsibleOfYourFamily = ((items?[3].items?[6] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace
        modelFields.financial_haveAContingencyPlanInCaseOfDisabblity = (items?[3].items?[7] as? FormTextField)?.fields?[0].value as? String == "Yes" ? true:false
        modelFields.financial_contingencyPlan = ((items?[3].items?[7] as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace
        modelFields.financial_youHaveAFinancialPlanOfRetriement = (items?[3].items?[8] as? FormTextField)?.fields?[0].value as? String == "Yes" ? true: false
        modelFields.financial_whatThePlan = ((items?[3].items?[8] as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace
        modelFields.financial_atWhatAgeWouldYouLikeToRetire = ((items?[3].items?[9] as? FormTextField)?.fields?[0].value as? String)?.stringToInt16()
       
        
        let dateOfMeeting = ((items?[3].items?[9] as? FormTextField)?.fields?[1].value as? String)?.trimWhiteSpace
        modelFields.financial_dateOfMeeting = dateOfMeeting?.stringToDateWithFormat(format: "dd/MM/yyyy")
        
         modelFields.financial_howManyYearForFamily = ((items?[3].items?[10] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace
        
        modelFields.financial_doYouhaveSpouse = ((items?[3].items?[11] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace
        
         modelFields.financial_retirement = ((items?[3].items?[12] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace
        
        modelFields.financial_mortgagePayment = ((items?[3].items?[13] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace
        
         modelFields.financial_insured = ((items?[3].items?[14] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace
        
         modelFields.financial_moneyNeedByFamily = ((items?[3].items?[15] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace
        
        modelFields.financial_protection = ((items?[3].items?[16] as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace
        
        
        var childrenModels = [ChildrenDependent]()
        (items?[2].items as? [FormTextField])?.forEach({ (cell) in
            //cell.fields?.first?.value
            let childrenModelValue = ChildrenDependent()
            childrenModelValue.children_fullname = cell.fields?[0].value as? String
            print(cell.fields?[1].value as? String)
            childrenModelValue.children_dob = (cell.fields?[1].value as? String)?.stringToDateWithFormat(format: "dd/MM/yyyy")//item.tf2Value as? String
            childrenModels.append(childrenModelValue)
        })
        
        modelFields.childrenDependent = childrenModels
        
        if Validate.shared.editMain {
            Validate.shared.editMain = false
            
            CoreDataHelper.shared.updatePersonalForm(userID: Validate.shared.profileData?.contactInfo?.userId, modelfields: modelFields) { (success) in
                //Do something
            }
            
            
        } else {
            CoreDataHelper.shared.saveForm(formType: formType, data: modelFields)
        }
        
        
        
        let alert = UIAlertController(title: VCLiteral.VD_CF_SUCCESS.localized, message: VCLiteral.VD_CF_DATA_SAVED_SUCCESSFULLY.localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: { (_) in
            self.items = FormModel.getSectionWiseData(for: self.formType)
            self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items ?? []), .FullReload)
            Validate.shared.editMain = false
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
}

//MARK: Cell Textfield & KeyMen Textfield Validation And Assigning Data to the Models - Company
extension FormVC {

    func saveCompanyData() {
        
        var keyMenModels = [KeyMenModels]()
        (items?[2].items as? [FormTextField])?.forEach({ (cell) in
            //cell.fields?.first?.value
            let keyMenModelValue = KeyMenModels()
            keyMenModelValue.keymen_userId = userId
            keyMenModelValue.keyMen_fullName = (cell.fields?[0].value as? String)?.trimWhiteSpace
            
            
            keyMenModelValue.keyMen_dob = (cell.fields?[1].value as? String)?.stringToKeyMenDate()
            keyMenModelValue.keyMen_sharePercentage = Int(cell.fields?[2].value as? String ?? "") ?? 0
            keyMenModelValue.keyMen_Smoke = cell.fields?[4].value as? String == "Yes" ? true:false
            keyMenModelValue.keyMen_prizeAmount = Int(cell.fields?[4].value as? String ?? "") ?? 0//item.tf5Value as? String
            keyMenModelValue.keyMen_DefferedCompensation = cell.fields?[5].value as? String
            keyMenModels.append(keyMenModelValue)
        })
        
        modelFields.keyMen = keyMenModels
        modelFields.contact_userId = userId
        modelFields.contact_fullName = ((items?[0].items?.first as? FormTextField)?.fields?[0].value as? String)?.trimWhiteSpace
        modelFields.contact_email = (items?[0].items?.first as? FormTextField)?.fields?[1].value as? String
        modelFields.contact_whatsAppNumber = (items?[0].items?.first as? FormTextField)?.fields?[2].value as? String
        modelFields.personal_userId = userId
        modelFields.personal_dob = ((items?[1].items?.first as? FormTextField)?.fields?[0].value as? String)?.stringToDateWithFormat(format: "dd/MM/yyyy")
        modelFields.personal_smoke = (items?[1].items?.first as? FormTextField)?.fields?[1].value as? String == "Yes" ? true: false
        
        modelFields.financial_dateOfMeeting = ((items?[3].items?.first as? FormTextField)?.fields?[0].value as? String)?.stringToDateWithFormat(format: "dd/MM/yyyy")
        
        if Validate.shared.editMain {
            Validate.shared.editMain = false
            
                CoreDataHelper.shared.updateCompanyData(userID: Validate.shared.profileData?.contactInfo?.userId, modelfields: modelFields) { (success) in
                    //Do something
                }
        
            
           
        } else {
            CoreDataHelper.shared.saveForm(formType: formType, data: modelFields)
        }
        
        
        let alert = UIAlertController(title: VCLiteral.VD_CF_SUCCESS.localized, message: VCLiteral.VD_CF_DATA_SAVED_SUCCESSFULLY.localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: { (_) in
            self.items = FormModel.getSectionWiseData(for: self.formType)
            self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items ?? []), .FullReload)
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


