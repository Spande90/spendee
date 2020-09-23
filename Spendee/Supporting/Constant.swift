//
//  Constant.swift
//  Spendee
//
//  Created by Siddharth on 7/25/19.
//  Copyright © 2019 TechnoPear. All rights reserved.
//

import Foundation
import UIKit

struct Defaults{
    static let userDefaults = UserDefaults.standard
}
struct LightMode{
    static let primaryColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let secondaryColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
}

struct DarkMode {
    static let primaryColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let secondaryColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
}

struct Screen{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}
