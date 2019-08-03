//
//  Colors.swift
//  Aldrete & Asociados
//
//  Created by Sandeep Kumar on 23/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

enum Colors: String {
    case APP_THEME = "appTheme"
    case BLUE_TINT = "blueTint"
    case CELL_BACKGROUND = "cellBackground"
    case CELL_SELECTED = "cellSelected"
    case GREEN_TINT = "greenTint"
    case NAVIGATION_BAR = "navigationBar"
    case RED_TINT = "redTint"
    case SEPARATOR = "separator"
    case TABLE_SECTION_GREY = "tableSectionColorGrey"
    case TABLE_SECTION_WHITE = "tableSectionWhite"
    case TEXT_PRIMARY = "textPrimary"
    case TEXT_SECONDARY = "textSecondary"
    case TEXT_WHITE = "textWhite"
    
    var uiColor: UIColor {
        return UIColor(named: self.rawValue) ?? UIColor()
    }
}
