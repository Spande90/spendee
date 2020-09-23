//
//  Entry.swift
//  Spendee
//
//  Created by Siddharth on 7/25/19.
//  Copyright © 2019 TechnoPear. All rights reserved.
//

import Foundation
import UIKit

class Entry {
    
    var Amount:String
    var Operation:String
    init(amount:String,operation:String) {
        self.Amount = amount
        self.Operation = operation
    }
}
