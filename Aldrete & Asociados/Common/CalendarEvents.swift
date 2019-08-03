//
//  CalendarEvents.swift
//  Aldrete & Asociados
//
//  Created by sandeep on 27/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import Foundation
import UIKit
import EventKit

class CalendarEvents: NSObject {
    var title: String?
    var startDate: Date?
    var endDate: Date?
    var desc: String?
    var isAllDay: Bool?
    
    init(_ title_: String?, _ startDate_: Date?, _ endDate_: Date?, _ desc_: String?, _ isAllDay_: Bool?) {
        title = title_
        startDate = startDate_
        endDate = endDate_
        desc = desc_
        isAllDay = isAllDay_
    }
    
    override init() {
        
    }
}

enum Repeat: String {
    case option1 = "Never"
    case option2 = "Every Day"
    case option3 = "Every Week"
    case option4 = "Every 2 Weeks"
    case option5 = "Every Month"
    case option6 = "Every Year"
    
    func localized() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

@objc protocol CalendarMangerDelegate {
    @objc optional func getCalEvents(events: [CalendarEvents], calGroupName: String)
    @objc optional func getCurrentSavedEvent(event: CalendarEvents)
}

class CalendarManger: NSObject {
    
   static let sharedInstance = CalendarManger()
     let eventStore = EKEventStore()
    
    func fetchLocalEventMatching(_ meeting: MeetingData) -> EKEvent{
        let calendars = eventStore.calendars(for: .event)
        let sixMonthAgo = Date(timeIntervalSinceNow: -(6*30)*24*3600) //from currentDate
        let sixMonthsAfter = Date(timeIntervalSinceNow: +(6*30)*24*3600)//from currentDate
        
        let predicate = eventStore.predicateForEvents(withStart: sixMonthAgo, end: sixMonthsAfter, calendars: calendars)
        let events = eventStore.events(matching: predicate)
        
        let selectedEvent = events.first(where: { $0.title == meeting.meetingTitle && $0.startDate == meeting.starttime && $0.endDate == meeting.endtime })
        
        
        return selectedEvent!
        
    }
    
    func fetchUpdateLocalEventMatching(_ meeting: AddMeetingModel) -> EKEvent{
        let calendars = eventStore.calendars(for: .event)
        let sixMonthAgo = Date(timeIntervalSinceNow: -(6*30)*24*3600) //from currentDate
        let sixMonthsAfter = Date(timeIntervalSinceNow: +(6*30)*24*3600)//from currentDate
        
        let predicate = eventStore.predicateForEvents(withStart: sixMonthAgo, end: sixMonthsAfter, calendars: calendars)
        let events = eventStore.events(matching: predicate)
        
        let selectedEvent = events.first(where: { $0.title == meeting.meetingName && $0.startDate == meeting.meetingStartTime && $0.endDate == meeting.meetingEndTime })
        
        
        return selectedEvent!
        
    }
    
    
    func deleteEntry(event : EKEvent) -> Bool{

        do{
            try eventStore.remove(event, span: .thisEvent, commit: true)
            
            return true
           
        }catch{
            print("Error while deleting event: \(error.localizedDescription)")
            
            return false
        }
    }
    
    
    
    
//    func requestAccessToCalendar() {
//        eventStore.requestAccess(to: EKEntityType.event, completion: {
//            (accessGranted: Bool, error: Error?) in
//            if accessGranted == true {
//                DispatchQueue.main.async(execute: {
//                    self.createCalGroup()
//                })
//            } else {
//                DispatchQueue.main.async(execute: {
//                    self.requestAccessToCalendar()
//                })
//            }
//        })
//    }
    
//    func createCalGroup() {
//        groupNames?.forEach { (groupName) in
//            if /UserDefaults.standard.string(forKey: groupName) == "" {
//                let newCalendar = EKCalendar.init(for: .event, eventStore: eventStore)
//                newCalendar.title = /groupName
//                let sourcesInEventStore = eventStore.sources
//                print("Sources: ", sourcesInEventStore)
//
//                //                let newCalendar = EKCalendar.init(for: .event, eventStore: eventStore)
//                //                newCalendar.title = /groupName
//                //                let sourceInEventStore = eventStore.sources.filter({ (source) -> Bool in
//                //                    return source.title == "iCloud"
//                //                })
//                //
//                //                if sourceInEventStore.count == 0{
//                //                    return
//                //                }
//                //                newCalendar.source = sourceInEventStore.first ?? EKSource()
//                //
//                print("+++++++++++++++++++", sourcesInEventStore)
//                sourcesInEventStore.forEach({ (calendarSource) in
//                    print("Hello", calendarSource.title)
//                    if calendarSource.sourceType == EKSourceType.calDAV {
//                        newCalendar.source = calendarSource
//                        return
//                    } else if calendarSource.sourceType == EKSourceType.local {
//                        newCalendar.source = calendarSource
//                        print(calendarSource, "Local")
//                        return
//                    } else if calendarSource.sourceType == EKSourceType.subscribed {
//                        newCalendar.source = calendarSource
//                        print(calendarSource, "Subscribed")
//                        return
//                    }
//                })
//                //
//                //                do {
//                //                    try eventStore.saveCalendar(newCalendar, commit: true)
//                //                    UserDefaults.standard.set(newCalendar.calendarIdentifier, forKey: /groupName)
//                //                } catch {
//                //                    let alert = UIAlertController(title: "Calendar could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
//                //                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                //                    alert.addAction(OKAction)
//                //                    instanceView?.present(alert, animated: true, completion: nil)
//                //                }
//            }
//        }
//    }
    
//    func addEventToCalendar(title: String, description: String, startDate: Date, endDate: Date, isAllDay_: Bool?, repeatOption: Repeat, groupName: String) {
//        var calendar: EKCalendar?
//        let calendars = eventStore.calendars(for: .event)
//        let event = EKEvent.init(eventStore: eventStore)
//        let alarm1hour = EKAlarm(relativeOffset: -3600) //1 hour before
//        let alarm1day = EKAlarm(relativeOffset: -86400) //1 day before
//        event.addAlarm(alarm1day)
//        event.addAlarm(alarm1hour)
//        event.title = title
//        event.notes = description
//        event.startDate = startDate
//        event.endDate = endDate
//        event.isAllDay = isAllDay_ ?? false
//
//        if let recurrenceRule: EKRecurrenceRule = getRepeatValue(repeatOption) {
//            event.addRecurrenceRule(recurrenceRule)
//        }
//
//        calendars.forEach { (calOption) in
//            if calOption.calendarIdentifier == UserDefaults.standard.string(forKey: groupName) {
//                calendar = calOption
//            }
//        }
//
//        event.calendar = calendar ?? eventStore.defaultCalendarForNewEvents
//
//        do {
//            try eventStore.save(event, span: .thisEvent)
//            print("Success", event.eventIdentifier)
//            delegate?.getCurrentSavedEvent?(event: CalendarEvents(title, startDate, endDate, description, isAllDay_))
//        } catch let error as NSError {
//            print("failed to save event with error : \(error)")
//        }
//    }
    
    //    func addReminder(title: String, description: String, startDate: Date, endDate: Date, isAllDay_: Bool?, repeatOption: Repeat, groupName: String) {
    //        var calendar: EKCalendar?
    //        let calendars = eventStore.calendars(for: .reminder)
    //        var reminder = EKReminder.init(eventStore: eventStore)
    //        reminder.title = title
    //    }
    
    
//    func assignLocalEventsToArray(_ predicate: NSPredicate, _ events: [EKEvent], _ groupName: String) {
//        var eventsArray = [CalendarEvents]()
//        events.forEach { (event) in
//            eventsArray.append(CalendarEvents(event.title, event.startDate, event.endDate, event.notes, event.isAllDay))
//            print(/event.title)
//        }
//        delegate?.getCalEvents?(events: eventsArray, calGroupName: groupName)
//    }
    
    
//    func getRepeatValue (_ option : Repeat) -> EKRecurrenceRule? {
//        switch option {
//        case .option1:
//            return nil
//        case .option2:
//            let rule = EKRecurrenceRule(recurrenceWith: EKRecurrenceFrequency.daily, interval: 1, end: nil)
//            //daily for 50 years
//            return rule
//        case .option3:
//            //on the same week day for 50 years
//            let rule = EKRecurrenceRule(recurrenceWith: EKRecurrenceFrequency.weekly, interval: 1, end: nil)
//            return rule
//        case .option4:
//            //on same weekday after 2 weeks
//            let rule = EKRecurrenceRule(recurrenceWith: EKRecurrenceFrequency.weekly, interval: 2, end: nil)
//            return rule
//        case .option5:
//            //on the same date of every month
//            let rule = EKRecurrenceRule(recurrenceWith: EKRecurrenceFrequency.monthly, interval: 1, end: nil)
//            return rule
//        case .option6:
//            //on the same date and month of the year
//            let rule = EKRecurrenceRule(recurrenceWith: EKRecurrenceFrequency.yearly, interval: 1, end: nil)
//            return rule
//        }
//    }
    
//    func deleteGroups() {
//        let calendars = eventStore.calendars(for: .event)
//        calendars.forEach { (calendar) in
//            print(calendar)
//            groupNames?.forEach({ (group) in
//                print(/UserDefaults.standard.string(forKey: group))
//                if /UserDefaults.standard.string(forKey: group) == calendar.calendarIdentifier {
//                    if let calendarToDelete: EKCalendar = eventStore.calendar(withIdentifier: calendar.calendarIdentifier) {
//                        print(calendarToDelete)
//                        UserDefaults.standard.removeObject(forKey: group)
//                        do {
//                            try eventStore.removeCalendar(calendarToDelete, commit: true)
//                        } catch {
//                            print("calender remove error")
//                        }
//                    }
//                }
//            })
//        }
//    }
}
