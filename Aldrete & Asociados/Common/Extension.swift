//
//  Extension.swift
//  Aldrete & Asociados
//
//  Created by NewMacMini1 on 05/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit
import Foundation

extension UITextField {
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.select) 
    }
}


extension Date {
    
    func isEqualTo(_ date: Date) -> Bool {
        return self == date
    }
    
    func isGreaterThan(_ date: Date) -> Bool {
        return self > date
    }
    
    func isEqualToGreaterThan(_ date: Date) -> Bool {
        return self >= date
    }
    
    func isSmallerThan(_ date: Date) -> Bool {
        return self < date
    }
    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == .orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    
    
}


extension Date {
    
    //date to string
    func dateToString(format:String)->String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format  //Your New Date format as per requirement change it own
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let newDate = dateFormatter.string(from: self)
        return newDate
    }
    
    //Calculate Age
    
    var age: Int {
        //   return Calendar.current.component(.Year, from: self )
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
        // return NSCalendar.currentCalendar.components(.Year, fromDate: self, toDate: NSDate(), options: []).year
    }
}



extension Int64 {
    
    func intergerToString() -> String {
        return String(self)
    }
    
}

extension Int16 {
    
    func intergerToString() -> String {
        return String(self)
    }
    
}

extension Double {
    
    func doubleToString() -> String {
        return String(self)
    }
    
}



