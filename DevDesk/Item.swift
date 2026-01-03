//
//  Item.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
