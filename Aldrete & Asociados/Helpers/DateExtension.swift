//
//  File.swift
//  Aldrete & Asociados
//
//  Created by NewMacMini1 on 02/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import Foundation

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
