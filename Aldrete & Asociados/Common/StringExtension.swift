//
//  StringExtension.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 25/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

extension String {
    
  func getAttributedName() -> NSMutableAttributedString {
    let nameFormatter = PersonNameComponentsFormatter()
    
    let nameComps = nameFormatter.personNameComponents(from: self)
    let givenName = /nameComps?.givenName
    
    let attributedString = NSMutableAttributedString.init(string: self, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)])
    
    let range = (self as NSString).range(of: /givenName)
    attributedString.addAttributes([.font: UIFont.systemFont(ofSize: 18, weight: .semibold)], range: range)
    return attributedString
  }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func isValidUserName() -> Bool {
        let nameRegEx = "^[a-zA-Z0-9._]+$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }
    
    func containsNumberOnly() -> Bool {
        let nameRegEx = "^[0-9]+$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }
    
    func isContainsAllZeros() -> Bool {
        let mobileNoRegEx = "^0*$";
        let mobileNoTest = NSPredicate(format:"SELF MATCHES %@", mobileNoRegEx)
        return mobileNoTest.evaluate(with: self)
    }
    
    
    
    
    var trimWhiteSpace: String {
        let trimmedString = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString
    }
    
    var isEmail: Bool {
        let regex = try? NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    
    var length: Int {
        return self.count
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    //string to date
    func stringToDate()->Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        let date1 = dateFormatter.date(from: String(self)) //according to date format your date string
        return date1 ?? Date()
    }
    
    //string to date
    func stringToKeyMenDate()->Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd/MM/yyyy" //Your date format
        let date1 = dateFormatter.date(from: String(self)) //according to date format your date string
        return date1 ?? Date()
    }
    
    
    
    func stringToFullDateFormat()->Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" //Your date format
        let date1 = dateFormatter.date(from: String(self)) //according to date format your date string
        return date1 ?? Date()
    }
    
    
    //"yyyy-MM-dd HH:mm:ss.SSSSSSS"
    //string to date
    func stringToDateWithFormat(format:String)->Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format //Your date format
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let date1 = dateFormatter.date(from: String(self)) //according to date format your date string
        return date1 ?? Date()
    }
    
    func miliSecondToDateString(format: String) -> String{
        
        guard let miliScnd = Double(String(self)) else {return ""}
        let dateVar = Date.init(timeIntervalSince1970: TimeInterval(miliScnd/1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: dateVar)
    }
    
    func stringToDouble() -> Double {
        return Double(self) ?? 0.0
    }
    
    func stringToInt16() -> Int16 {
        return Int16(self) ?? 0
    }
    func stringToInt64() -> Int64 {
        return Int64(self) ?? 0
    }
    
}
