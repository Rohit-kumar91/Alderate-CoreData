//
//  DetailVC.swift
//  Aldrete & Asociados
//
//  Created by Sandeep Kumar on 23/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: BaseVC {
  
  @IBOutlet weak var noUpcomingLabel: UILabel!
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.registerXIBForHeaderFooter(DetailSection.identfier)
      tableView.registerXIB(MeetingLocationCell.identfier)
      tableView.registerXIB(MeetingDateTimeCell.identfier)
      tableView.registerXIB(MeetingCalendarCell.identfier)
      tableView.registerXIB(MeetingPPTCell.identfier)
      tableView.delegate = self
      tableView.dataSource = self
    }
  }
  
  //MARK:- Properties
  private var items: [DetailSectionModel]?
  var meetingModels = [MeetingData]()
  var filterMeetingModels = [MeetingData]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //items = DetailSectionModel.getSectionalData()
    tableView.register(UINib(nibName: "MeetingInfoCell", bundle: nil), forCellReuseIdentifier: "MeetingInfoCell")
    searchBar.delegate = self
   
  }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         NotificationCenter.default.addObserver(self, selector: #selector(updateData(notification:)), name: Notification.Name("UpdateData"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(filterData(notification:)), name: Notification.Name("filterArrayAccordingToDate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateData(notification:)), name: Notification.Name("resetDate"), object: nil)
        
    
        fetchMeetings()
        searchBar.delegate = self
        tableView.reloadData()
    }
    
    
    deinit {
        //Notifiction.....
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("UpdateData"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("filterArrayAccordingToDate"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("resetDate"), object: nil)
    }
    
    @objc private func updateData(notification: NSNotification){
        
        fetchMeetings()
        searchBar.delegate = self
        tableView.reloadData()
    }
    
   
    
    @objc private func filterData(notification: NSNotification){
        
        if let date = notification.userInfo?["selectedDate"] as? String {
            filterDataAccDate(selectedDate: date)
        }
        
    }
    
    func fetchMeetings() {
        
        CoreDataHelper.shared.fetch(entityName: EntityName.MeetingCD) { (values, success) in
            if success {
                
                let meetingCD = values as! [MeetingCD]
                filterMeetingModels.removeAll()
                meetingModels.removeAll()
                for meeting in meetingCD {
                    
                    if (meeting.startTime?.isGreaterThanDate(dateToCompare: Date()))! { // date check
                        
                        if Int16(Validate.shared.type.rawValue) == meeting.formType {
                            meetingModels.append(MeetingData(date: meeting.date,
                                                             endTime: meeting.endTime,
                                                             location: meeting.location,
                                                             meetingTitle: meeting.meetingTitle,
                                                             presentation: meeting.presentation,
                                                             starttime: meeting.startTime,
                                                             userId: meeting.userId, userName: meeting.userName,
                                                             meetingId: meeting.meetingId, formType: meeting.formType
                                
                            ))
                        }
                        
                       
                    }
                    
                    
                    if meetingModels.count == 0 {
                        self.noUpcomingLabel.isHidden = false
                    } else {
                        self.noUpcomingLabel.isHidden = true
                    }
                }
                meetingModels.forEach({ (meetings) in
                    
                    //if !(filterMeetingModels.contains(meetings)) {
                        filterMeetingModels.append(meetings)
                    //}
                })
             
                print(filterMeetingModels.count)
                tableView.isHidden = false
                noUpcomingLabel.isHidden = true
                tableView.reloadData()
                
                
            } else {
                alertWithDesc(desc: "Something Wrong.")
            }
        }
    }
}

//MARK:- UITableView Delegate and datasource
extension DetailVC: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filterMeetingModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MeetingInfoCell", for: indexPath) as! MeetingInfoCell
    cell.meetingWithLbl.text = filterMeetingModels[indexPath.row].userName
    cell.meetingLabel.isHidden = true
    cell.NameStackview.isHidden = false
    cell.btnMore.isHidden = false
    cell.meetingLocation.text = filterMeetingModels[indexPath.row].location
    cell.meetingDate.text = filterMeetingModels[indexPath.row].date?.dateToString(format: "EEEE, MMM d, yyyy")
    
    cell.didTapDeleteMeeting = {[weak self] (sender) in
        //Delete Meeting.
        self?.alertBoxOKCancel(title: "Delete Meeting", message: VCLiteral.DELETE_MEETING.localized, tapped: {
            
            guard let meetingId = self?.filterMeetingModels[indexPath.row].meetingId, let modalMeeting = self?.filterMeetingModels[indexPath.row] else { return }
            
            self?.deleteMeetingFromCD(meetingId: meetingId, index: indexPath,meeting: modalMeeting)
            //self?.tableView.reloadData()
            
        }, cancelTapped: {
            //Cancel
        })
        
    }
    //More Option....
    cell.didTapMoreAction = { [weak self] (sender) in
        
        let controller = ArrayChoiceTableViewController(VCLiteral.allHomeValues) { (index) in
            if index.rawValue == VCLiteral.UPLOAD_PRESENTATION.rawValue  {
                //upload Presentation
                self?.loadPDFAndShare(sender: sender)
               
            } else if index.rawValue ==  VCLiteral.RESCHEDULE.rawValue {
                
//                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let popupVC = storyboard.instantiateViewController(withIdentifier: "AddMeetingVC") as! AddMeetingVC
////                //popupVC.modalPresentationStyle = .popover
////                popupVC.didTapFetchAction = {
////                    self.fetchMeetings()
////                    self.tableView.reloadData()
////                }
////                popupVC.userID = self.userId
////                popupVC.userName = contactName
////                print(self?.meetingModels[sender.tag].date)
////
////                print(self?.meetingModels[sender.tag].starttime)
//                print(indexPath.row)
//                popupVC.meetingModels = self?.meetingModels[indexPath.row]
//                
//                popupVC.modalPresentationStyle = .overCurrentContext
//                popupVC.modalTransitionStyle = .crossDissolve
//                
//                let win = UIWindow(frame: UIScreen.main.bounds)
//                let vc = UIViewController()
//                vc.view.backgroundColor = .clear
//                win.rootViewController = vc
//                win.windowLevel = UIWindow.Level.alert + 1
//                win.makeKeyAndVisible()
//                vc.present(popupVC, animated: true, completion: nil)
                
                //Reshedule
            }
        }
        
        controller.preferredContentSize = CGSize(width: 300, height: 100)
        self?.showPopup(controller, sourceView: sender)
        
    }
    
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
    
    
    if let startTime = filterMeetingModels[indexPath.row].starttime?.dateToString(format: "hh:mm a"), let endTime = filterMeetingModels[indexPath.row].endtime?.dateToString(format: "hh:mm a") {
        cell.meetingTime.text = startTime + " to " + endTime
    } else {
        cell.meetingTime.text = ""
    }
    
    return cell
    
  }
  

  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 380
  }
  
}

extension DetailVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filterMeetingModels = meetingModels
        } else {
            // Filter the results
            filterMeetingModels = meetingModels.filter { $0.userName?.lowercased().contains(searchText.lowercased()) ?? false }
        }
        
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        searchBar.text = ""
        filterMeetingModels = meetingModels
        self.tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    //Delete Meeting from the core data.
    private func deleteMeetingFromCD(meetingId: String, index: IndexPath,meeting: MeetingData) {
        
         let selectedEvent = CalendarManger.sharedInstance.fetchLocalEventMatching(meeting)
        
        if CalendarManger.sharedInstance.deleteEntry(event: selectedEvent) {
            self.deleteMeetingData(meetingId: meetingId, index: index)
        }
        
        
    }
    
    private func deleteMeetingData(meetingId: String, index: IndexPath) {
        CoreDataHelper.shared.deleteMeeting(meetingID: meetingId) { (success) in
            if success {
                
                //contactArray[2].remove(at: index.row)
                filterMeetingModels.remove(at: index.row)
                
                if filterMeetingModels.count == 0 {
                    noUpcomingLabel.isHidden = false
                    tableView.isHidden = true
                    tableView.reloadData()
                    
                }
                else {
                      tableView.reloadData()
                }
                
                
                //let indexPath = IndexPath(item: index.row, section: 0)
                //tableView.deleteRows(at: [indexPath], with: .fade)
              
            } else {
                
            }
        }
    }
    
    
    private func showPopup(_ controller: UIViewController, sourceView: UIView) {
        let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
        presentationController.sourceView = sourceView
        presentationController.sourceRect = sourceView.bounds
        presentationController.permittedArrowDirections = [.down, .up]
        self.present(controller, animated: true)
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
    
    //Share PDF
    func getDirectoryPath() -> String {
        let stringPath = Bundle.main.path(forResource: "App-Brewery", ofType: "pdf")
        return stringPath!
    }
}
extension DetailVC {
    
    fileprivate func filterDataAccDate(selectedDate: String?) {
        
        var filterDateArray = [MeetingData]()
        
        meetingModels.forEach { (meeting) in
        
            if meeting.date?.dateToString(format: "dd/MM/yyyy") == selectedDate {
                
               filterDateArray.append(meeting)
                
                  print(filterDateArray.count)
                
                filterMeetingModels.removeAll()
                
            }
            if filterDateArray.count > 0 {
                
                noUpcomingLabel.isHidden = true
                filterMeetingModels = filterDateArray
                tableView.isHidden = false
            }
            else if filterDateArray.count == 0 {
                noUpcomingLabel.isHidden = false
                tableView.isHidden = true
                
            }
            
            tableView.reloadData()
        }
        
    }
    
    
    
}


