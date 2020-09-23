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
    static let rupee = "\u{20B9}"
    static let keyboard:[String] = ["7","8","9","4","5","6","1","2","3",".","0","x"]
    static let keyboardViewHeight:CGFloat = 300
    static let Total = "Total: "
}


struct Screen{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}

struct Mode {
    static let darkMode = "dark"
    static let lightMode = "light"
}

