//
//  Theme.swift
//  tips
//
//  Created by Labuser on 12/15/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

import UIKit

enum Theme: Int {
    case Light, Dark
    
    var mainColor: UIColor {
        switch self {
        case .Light:
            return UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        case .Dark:
            return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        }
    }
}

struct ThemeManager {
    static func currentTheme() -> Theme {
        if let storedTheme = NSUserDefaults.standardUserDefaults().valueForKey("selectedTheme")?.integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .Light
        }
    }
    
    static func applyTheme(theme: Theme) {
        NSUserDefaults.standardUserDefaults().setValue(theme.rawValue, forKey: "selectedTheme")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let sharedApplication = UIApplication.sharedApplication()
        sharedApplication.delegate?.window??.tintColor = theme.mainColor
    }
}