//
//  ContactInfoVC.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 01/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit
import CoreData
import EventKit

class ContactInfoVC: BaseVC {
  
    var contactName = String()
    var contactNumber = String()
    var contactId = String()
    var contactStatus = String()
    var contactNotes = String()
    var userId = String()
    var type = String()
    var meetingModels = [MeetingData]()
    var contactsNumbers = [ContactsNumbers]()
    var contactArray = [[Any]]()
    var notes = String()
    var isstatusEdit = false
    var isStatusChange: (() -> Void)?
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Properties
    var items: [ContactDetailModel]?
    var profileData: ProfileFullData? {
        didSet {
            //items = ContactDetailModel.getSectionalData(profileData)
            contactId = (profileData?.contactInfo?.userId)!
            contactName = (profileData?.contactInfo?.fullName)!
            contactNumber = (profileData?.contactInfo?.whatsAppNumber)!
            contactNotes = profileData?.contactInfo?.notes ?? ""
            contactStatus = profileData?.contactInfo?.status ?? ""
            
            contactsNumbers.removeAll()
            contactsNumbers.append(ContactsNumbers(contactNumber: contactNumber, contactType: "Main"))
            userId = (profileData?.contactInfo?.userId)!
            
            Validate.shared.profileData = self.profileData
            contactArray = [[contactName],[contactsNumbers],[meetingModels],[contactStatus],[contactNotes]]
            
            self.fetchContactInfo()
            self.fetchContacts()
            self.fetchMeetings()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(backToHome(notification:)), name: Notification.Name("backToHome"), object: nil)
        tableView.register(UINib(nibName: "ContactDetailCell", bundle: nil), forCellReuseIdentifier: "ContactDetailCell")
        tableView.register(UINib(nibName: "MeetingInfoCell", bundle: nil), forCellReuseIdentifier: "MeetingInfoCell")
        tableView.register(UINib(nibName: "StatusCell", bundle: nil), forCellReuseIdentifier: "StatusCell")
        tableView.register(UINib(nibName: "UserInformationCell", bundle: nil), forCellReuseIdentifier: "UserInformationCell")
        tableView.register(UINib(nibName: "NotesCell", bundle: nil), forCellReuseIdentifier: "NotesCell")
        
    }
    
    
    @objc private func backToHome(notification: NSNotification){
        
        //do stuff using the userInfo property of the notification object
      popVC()
    }
    
    
    func fetchContactInfo() {
        CoreDataHelper.shared.fetchWithUserID(userID: userId, entityName: "ContactInfoCD") { (values, success) in
            if success {
                let contactInfo = values as! [ContactInfoCD]
                for contact in contactInfo {
                    self.notes = contact.notes ?? ""
                }
                
            } else {
                alertWithDesc(desc: "Something Wrong.")
            }
        }
    }
    
    
    func fetchMeetings() {
        
        CoreDataHelper.shared.fetchWithUserID(userID: userId, entityName: "MeetingCD") { (values, success) in
            if success {
                let meetingCD = values as! [MeetingCD]
                meetingModels.removeAll()
                for meeting in meetingCD {
                    
                    if Int16(Validate.shared.type.rawValue) == meeting.formType {
                        
                        meetingModels.append(MeetingData(date: meeting.date,
                                                         endTime: meeting.endTime,
                                                         location: meeting.location,
                                                         meetingTitle: meeting.meetingTitle,
                                                         presentation: meeting.presentation,
                                                         starttime: meeting.startTime,
                                                         userId: meeting.userId, userName: meeting.userName, meetingId: meeting.meetingId, formType: meeting.formType))
                    }
                    
                }
                
                contactArray[2] = meetingModels
                
                
            } else {
                alertWithDesc(desc: "Something Wrong.")
            }
        }
    }
    
    
    func fetchContacts() {
        
        CoreDataHelper.shared.fetchWithUserID(userID: userId, entityName: "ContactPhoneNumberCD") { (values, success) in
            
            if success {
                let contacts = values as! [ContactPhoneNumberCD]
                let contactNumber  = contactsNumbers[0]
                contactsNumbers.removeAll()
                contactsNumbers.append(contactNumber)
                for contactdata in contacts {
                    contactsNumbers.append(ContactsNumbers(contactNumber: contactdata.contactNumber ?? "", contactType: contactdata.contactType ?? ""))
                }
                contactArray[1] = contactsNumbers
                
            } else {
                alertWithDesc(desc: "Something Wrong.")
            }
        }
    }
    
    
    @IBAction func addContactAction(_ sender: Any) {
        AddContactPopUp()
    }
    
    
    func showAddMeetingPopup() {
        
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popupVC = storyboard.instantiateViewController(withIdentifier: "AddMeetingVC") as! AddMeetingVC
        //popupVC.modalPresentationStyle = .popover
        popupVC.didTapFetchAction = {
            self.fetchMeetings()
            self.tableView.reloadData()
        }
        popupVC.userID = self.userId
        popupVC.userName = contactName
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(popupVC, animated: true, completion: nil)
    }
    
    func AddContactPopUp() {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popupVC = storyboard.instantiateViewController(withIdentifier: "AddContactVC") as! AddContactVC
        
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.userID = self.userId
        popupVC.didTapFetchContactAction = {
            self.fetchContacts()
            self.tableView.reloadData()
        }
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(popupVC, animated: true, completion: nil)
    }
  
    private func showPopup(_ controller: UIViewController, sourceView: UIView) {
        let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
        presentationController.sourceView = sourceView
        presentationController.sourceRect = sourceView.bounds
        presentationController.permittedArrowDirections = [.down, .up]
        self.present(controller, animated: true)
    }
    
    //Delete Meeting from the core data.
    private func deleteMeetingFromCD(meetingId: String, index: IndexPath,meeting: MeetingData) {
        
       let selectedEvent = CalendarManger.sharedInstance.fetchLocalEventMatching(meeting)
        
        if CalendarManger.sharedInstance.deleteEntry(event: selectedEvent) {
            self.deleteMeetingData(meetingId: meetingId, index: index)
        }
        
    }
    
    func deleteMeetingData(meetingId: String, index: IndexPath) {
        CoreDataHelper.shared.deleteMeeting(meetingID: meetingId) { (success) in
            if success {
                
                contactArray[2].remove(at: index.row)
                meetingModels.remove(at: index.row)
            
//                let indexPath = IndexPath(item: index.row, section: 2)
//                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
                
                
                
                
            } else {
                
            }
        }
    }
    
    

    
  }

//MARK:- UITableView Delegate and datasource
extension ContactInfoVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell =  tableView.dequeueReusableCell(withIdentifier: "UserInformationCell", for: indexPath) as! UserInformationCell
            
            cell.userName.text = contactName
            
            
            
            switch Validate.shared.type {
            case .Company:
                cell.type.text = "Company"
                cell.typeImage.image =  #imageLiteral(resourceName: "ic_Conference")
            case .Person:
                cell.type.text = "Person"
                cell.typeImage.image =  #imageLiteral(resourceName: "ic_personal")
            default:
                cell.type.text = "Company"
            }
    
            //More Option....
            cell.didTapAdd = { [weak self] (sender) in
                                
                let controller = ArrayChoiceTableViewController(VCLiteral.allValues) { (index) in
                    if index.rawValue == VCLiteral.ADD_MEETING.rawValue  {
                        //Add Meeting
                        self?.showAddMeetingPopup()
                    } else if index.rawValue ==  VCLiteral.EDIT_STATUS.rawValue {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 3), at: .bottom, animated: true)
                        }
                       
                        self?.isstatusEdit = true
                        tableView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .none)
                      //  self?.isStatusChange?()
                        
                       // let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as? StatusCell
                        
                        //cell?.statusTextfield.becomeFirstResponder()
                        
                        //Edit Status
                    } else if index.rawValue ==  VCLiteral.EDIT_MAIN.rawValue {
                        //Edit Main
                        Validate.shared.editMain = true
                
                        
                        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
                        let viewController = appDelegate.window!.rootViewController as? UINavigationController
                    viewController?.topViewController?.pushVC(StoryboardScene.Main.FormVC.instantiate())
                        
                    } else if index.rawValue == VCLiteral.DELETE_CONTACT.rawValue {
                        //Delete Contact
                        
                        self?.alertBoxOKCancel(title: VCLiteral.DELETE_CONTACT.localized, message: VCLiteral.VD_ARE_YOU_SURE_TO_DELETE.localized, tapped: {
                            
                            guard let userId = self?.userId else { return }
                            CoreDataHelper.shared.deleteContact(userID: userId, completion: { (success) in
                                if success {
                                    NotificationCenter.default.post(name: Notification.Name("ReloadContactWhenDelete"), object: nil)
                                    self?.popVC(animated: true)
                                } else {
                                    //Alert...
                                }
                            })
                        }, cancelTapped: {
                            //Cancel
                        })
                    }
                }
                
                controller.preferredContentSize = CGSize(width: 300, height: 190)
                self?.showPopup(controller, sourceView: sender)
          
            }
            return cell
            
        case 1:
            let cell =  tableView.dequeueReusableCell(withIdentifier: "ContactDetailCell", for: indexPath) as! ContactDetailCell
            cell.contactType.text = contactsNumbers[indexPath.row].contactType
            cell.contactNumber.text = contactsNumbers[indexPath.row].contactNumber
            return cell
        
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MeetingInfoCell", for: indexPath) as! MeetingInfoCell
            if indexPath.row != 0 {
                cell.meetingLabel.isHidden = true
            }
            
            cell.meetingLocation.text = meetingModels[indexPath.row].location
            cell.btnMore.isHidden = true
            cell.meetingDate.text = meetingModels[indexPath.row].date?.dateToString(format: "EEEE, MMM d, yyyy")
            cell.deleteButtonOutlet.tag = indexPath.row
            
            switch Validate.shared.type {
            case .Company:
                cell.type.text = "Company"
                cell.typeImage.image =  #imageLiteral(resourceName: "ic_Conference")
            case .Person:
                cell.type.text = "Person"
                cell.typeImage.image =  #imageLiteral(resourceName: "ic_personal")
            default:
                cell.type.text = "Company"
            }
            
            
            if let startTime = meetingModels[indexPath.row].starttime?.dateToString(format: "hh:mm a"), let endTime = meetingModels[indexPath.row].endtime?.dateToString(format: "hh:mm a") {
                cell.meetingTime.text = startTime + " to " + endTime
            } else {
                cell.meetingTime.text = ""
            }
            
            cell.didTapDeleteMeeting = {[weak self] (sender) in
                //Delete Meeting.
                self?.alertBoxOKCancel(title: "Delete Meeting", message: VCLiteral.DELETE_MEETING.localized, tapped: {
                    
                    guard let meetingId = self?.meetingModels[indexPath.row].meetingId, let modalMeeting = self?.meetingModels[indexPath.row] else { return }
                    
                    self?.deleteMeetingFromCD(meetingId: meetingId, index: indexPath,meeting: modalMeeting)
                    
                }, cancelTapped: {
                    //Cancel
                })
                
            }
            
            return cell
            
        case 3:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell", for: indexPath) as! StatusCell
            cell.statusTextfield.text = contactStatus
            
            if self.isstatusEdit {
                cell.statusTextfield.becomeFirstResponder()
                self.isstatusEdit = false
            }
            cell.didStatusChange = {
                CoreDataHelper.shared.saveStatus(userID: self.userId, status: cell.statusValue, completion: { (success) in
                    if success {
                        self.profileData?.contactInfo?.status = cell.statusValue
                        self.contactStatus = cell.statusValue
                    } else {
                        
                    }
                })
            }
            
            
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath) as! NotesCell
            cell.textView.text = self.notes//contactArray[indexPath.section][0] as? String
            cell.didNotesTapAdd = {
                CoreDataHelper.shared.saveNotes(userID: self.contactId, notes: cell.notesData, completion: { ( success) in
                    if success {
                        
                    } else {
                        //Alert
                    }
                })
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 204
        case 1:
            return 76
        case 2:
            return 350
        case 3:
            return 77
        case 4:
            return 112
        default:
            return 0
        }
    }
}


