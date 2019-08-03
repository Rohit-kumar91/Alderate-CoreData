//
//  AddMeetingVC.swift
//  Aldrete & Asociados
//
//  Created by NewMacMini1 on 08/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit
import EventKit

class AddMeetingVC: UIViewController {

    @IBOutlet weak var meetingNameTextfield: UITextField!
    @IBOutlet weak var dateTextfield: UITextField!
    @IBOutlet weak var startTimeTextfield: UITextField!
    @IBOutlet weak var endTimeTextfield: UITextField!
    @IBOutlet weak var LocationTextfield: UITextField!
    @IBOutlet weak var presentationTextfield: UITextField!
    
    var formType = Int()
    var datePicker = UIDatePicker()
    var dateTime = String()
    var addMeetingModel = AddMeetingModel()
    var userID = String()
    var userName = String()
    var didTapFetchAction: (() -> Void)?
    var savedEventId : String = ""
    var eventAlreadyExists = false
    var meetingModels: MeetingData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if meetingModels != nil {
            setInitialData()
        }
        
    }
    
    fileprivate func setInitialData() {
        
        meetingNameTextfield.text = /meetingModels?.meetingTitle
        dateTextfield.text = /meetingModels?.date?.dateToString(format: "dd/MM/yyyy")
        startTimeTextfield.text = /meetingModels?.starttime?.dateToString(format: "hh:mm a")
        endTimeTextfield.text = /meetingModels?.endtime?.dateToString(format: "hh:mm a")
        LocationTextfield.text = /meetingModels?.location
        presentationTextfield.text = /meetingModels?.presenation
        
        addMeetingModel.meetingName = /meetingModels?.meetingTitle
        addMeetingModel.meetingStartTime = meetingModels?.starttime
        addMeetingModel.meetingEndTime = meetingModels?.endtime
        addMeetingModel.meetingDate = meetingModels?.date
        addMeetingModel.location = /meetingModels?.location
        addMeetingModel.presentation = /meetingModels?.presenation
        addMeetingModel.meetingId = /meetingModels?.meetingId
        
    }
    
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                
                let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
                let existingEvents = eventStore.events(matching: predicate)
                
               
                var eventExist = Bool()
                for singleEvent in existingEvents {
                    print("Event StartDate\(singleEvent.startDate), Event EndDate\(singleEvent.endDate)")
                    print("Event StartDate\(startDate), Event EndDate\(endDate)")
                    
                    if singleEvent.startDate == startDate && singleEvent.endDate == endDate {
                       eventExist = true
                    } else {
                       eventExist = false
                    }
                }
                
                //let eventAlreadyExists = existingEvents.contains(where: {event in event.startDate == startDate && event.endDate == endDate})

                if eventExist {
                    let alert = UIAlertController(title: "Event Already Exists", message: "Event Already Exists in Calendar", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    do {
                        try eventStore.save(event, span: .thisEvent)
                    } catch let e as NSError {
                        completion?(false, e)
                        return
                    }
                }
               
                completion?(true, nil)
            } else {
                completion?(false, error as NSError?)
            }
        })
    }
    
   
    
    func datePicker(datePickerMode: UIDatePicker.Mode, textField: UITextField) {
        
        let customView:UIView = UIView (frame: CGRect(x: 0, y: 100, width: 320, height: 160))
        customView.backgroundColor = .white
        datePicker = UIDatePicker(frame: CGRect(x: (self.view.bounds.size.width / 2) - 160, y: 0, width: 320, height: 160))
        datePicker.datePickerMode = datePickerMode
        if textField.tag == 3 {
            
            let dateMeeting: Date?
            
            if meetingModels != nil{
                dateMeeting = meetingModels?.date
                
            }
            else {
                dateMeeting = addMeetingModel.meetingDate
            }
            
            guard let meetingDate = dateMeeting  else {
                
                alertWithDesc(desc: "Select Meeting Date first.")
                self.view.endEditing(true)
                textField.text = ""
                return
            }
            
            datePicker.setDate(meetingDate, animated: false)
            if meetingDate.dateToString(format: "dd/MM/yyyy") == Date().dateToString(format: "dd/MM/yyyy") {
                datePicker.minimumDate = meetingDate
            }
            
        } else if textField.tag == 4 {
            
            let dateMeeting: Date?
            
            if meetingModels != nil{
                dateMeeting = meetingModels?.date
                
            }
            else {
                dateMeeting = addMeetingModel.meetingDate
            }
            
            
            guard let meetingDate = dateMeeting else {
                alertWithDesc(desc: "Select Meeting Date first.")
                self.view.endEditing(true)
                textField.text = ""
                return
            }
            
            guard let meetingStartTime = addMeetingModel.meetingStartTime else { return }
            datePicker.setDate(meetingStartTime, animated: false)
            //datePicker.minimumDate = addMeetingModel.meetingStartTime!
            if meetingDate.dateToString(format: "dd/MM/yyyy") == Date().dateToString(format: "dd/MM/yyyy") {
                datePicker.minimumDate = meetingDate
            }
            
        } else if textField.tag == 2 {
            datePicker.minimumDate = Date()
        }
        
        customView.addSubview(datePicker)
        textField.inputView = customView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = Colors.APP_THEME.uiColor
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(datePickerSelected))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func datePickerSelected() {
        self.view.endEditing(true)
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        self.view.endEditing(true)
        
//        if meetingModels != nil {
//
//            Validate.shared.validateAddMeetingTextfields(addMeeting: addMeetingModel) {[weak self] (errorMessage, success) in
//
//                if success {
//
//                    print("sucessss edit")
//                    print(addMeetingModel.meetingName)
//                    //D
//                    guard let meeting = meetingModels else { return }
//
//
//                    self?.deleteMeetingFromCalender(meetingId: meeting.meetingId, meeting: meeting)
//
//                    //ADD EVENT TO THE CALENDER
////                    self?.addEventToCalendar(title: /meetingModels?.meetingTitle, description: "", startDate:meetingModels?.starttime ?? Date(), endDate: meetingModels?.endtime ?? Date(), completion: { (success, error) in
////
////                        if success {
////
////                        } else {
////
////                        }
////                    })
////
////                    self?.meetingModels?.userId = self?.userID
////                    self?.meetingModels?.userName = self?.userName
////
////                    //Save Meeting
////                    CoreDataHelper.shared.saveMeeting(meetingModel: (self?.addMeetingModel)!, formType: Int16(Validate.shared.type.rawValue))
////                    self?.dismiss(animated: true, completion: nil)
////
////                    let alert = UIAlertController(title: VCLiteral.VD_CF_SUCCESS.localized, message: "Meeting saved successfully.", preferredStyle: .alert)
////                    alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: { (_) in
////                    }))
////                    self?.present(alert, animated: true, completion: nil)
////
////                    self?.didTapFetchAction?()
//
//                } else {
//
//                       print("error edit")
//
//                    //alertWithDesc(desc: errorMessage)
//                }
//            }
//        }
//        else {
        
            Validate.shared.validateAddMeetingTextfields(addMeeting: addMeetingModel) {[weak self] (errorMessage, success) in
                
                if success {
                    
                    //ADD EVENT TO THE CALENDER
                    self?.addEventToCalendar(title: /addMeetingModel.meetingName, description: "", startDate: addMeetingModel.meetingStartTime ?? Date(), endDate: addMeetingModel.meetingEndTime ?? Date(), completion: { (success, error) in
                        
                        if success {
                            
                        } else {
                            
                        }
                    })
                    
                    self?.addMeetingModel.userId = self?.userID
                    self?.addMeetingModel.userName = self?.userName
                    
                    //Save Meeting
                    CoreDataHelper.shared.saveMeeting(meetingModel: (self?.addMeetingModel)!, formType: Int16(Validate.shared.type.rawValue))
                    self?.dismiss(animated: true, completion: nil)
                    
                    let alert = UIAlertController(title: VCLiteral.VD_CF_SUCCESS.localized, message: "Meeting saved successfully.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: { (_) in
                    }))
                    self?.present(alert, animated: true, completion: nil)
                    
                    self?.didTapFetchAction?()
                    
                } else {
                    alertWithDesc(desc: errorMessage)
                }
            }
       // }
        
    }
    
    //Delete Meeting from the core data.
    private func deleteMeetingFromCalender(meetingId: String?,meeting: MeetingData) {
        
        meetingModels?.meetingTitle = addMeetingModel.meetingName
        meetingModels?.starttime = addMeetingModel.meetingStartTime
        meetingModels?.endtime = addMeetingModel.meetingEndTime
        meetingModels?.date = addMeetingModel.meetingDate
        meetingModels?.location = addMeetingModel.location
        meetingModels?.presenation = addMeetingModel.presentation
        meetingModels?.meetingId = addMeetingModel.meetingId

        let selectedEvent = CalendarManger.sharedInstance.fetchLocalEventMatching(meeting)
        
        if CalendarManger.sharedInstance.deleteEntry(event: selectedEvent) {
            CoreDataHelper.shared.updateMeetingData(meetingId: meetingId, modelfields: addMeetingModel) { (_) in
                //Pop Meeting Updated
                self.dismiss(animated: true, completion: nil)
                print("Successfull...")
            }
        }
    }
    
    
    
}

extension AddMeetingVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.autocorrectionType = .no
        switch textField.tag {
        case 1:
            //Meeting Name
            break
        case 2:
            //Date
            datePicker(datePickerMode: .date, textField: textField)
            break
        case 3:
            //start Time
            datePicker(datePickerMode: .time, textField: textField)
            endTimeTextfield.text = ""
            break
        case 4:
            //endTime
            datePicker(datePickerMode: .time, textField: textField)
            break
        case 5:
            //Presentation
            break
        case 6:
            //calender
            break
        default:
            print("Something went wrong.")
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            //Meeting Name
            addMeetingModel.meetingName = textField.text
            break
        case 2:
            //Date
            addMeetingModel.meetingDate = datePicker.date
            textField.text = datePicker.date.string(format: "dd/MM/yyyy")
            break
        case 3:
            //start Time
            
      
            addMeetingModel.meetingStartTime = datePicker.date
            textField.text = datePicker.date.string(format: "hh:mm a")
            break
        case 4:
            //endTime
            addMeetingModel.meetingEndTime = datePicker.date
            textField.text = datePicker.date.string(format: "hh:mm a")
            break
        case 5:
            //Location
            addMeetingModel.location = textField.text
            break
        case 6:
            //Location
            addMeetingModel.presentation = textField.text
            break
       
        default:
            print("Something went wrong.")
        }
    }
}

