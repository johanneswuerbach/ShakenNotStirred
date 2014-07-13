//
//  AddViewController.swift
//  ShakenNotStirred
//
//  Created by Daigo Kobayashi on 7/12/14.
//  Copyright (c) 2014 Slugfest. All rights reserved.
//

import UIKit

class AddViewController : UIViewController {
    
    var masterViewController : MasterViewController?
    
    @IBOutlet var nameField: UITextField
    
    @IBOutlet var notesField: UITextField
    
    @IBAction func save() {
        let bar = Bar(name: nameField.text, notes: notesField.text)
//        println(nameField.text)
        masterViewController?.addBar(bar)
    }
}
