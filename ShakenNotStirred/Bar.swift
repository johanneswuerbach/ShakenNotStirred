//
//  Bar.swift
//  ShakenNotStirred
//
//  Created by Johannes Würbach on 7/12/14.
//  Copyright (c) 2014 Slugfest. All rights reserved.
//

import UIKit

class Bar: NSObject {
    var name: String = ""
    var notes: String = ""
    
    init(name: String, notes: String) {
        self.name = name
        self.notes = notes
    }
}
