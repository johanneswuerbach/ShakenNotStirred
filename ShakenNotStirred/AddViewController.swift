//
//  AddViewController.swift
//  ShakenNotStirred
//
//  Created by Daigo Kobayashi on 7/12/14.
//  Copyright (c) 2014 Slugfest. All rights reserved.
//

import UIKit
import MobileCoreServices

class AddViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var masterViewController : MasterViewController?
    
    let bar = Bar()
    
    @IBOutlet var barPicturePreview: UIImageView
    @IBAction func capturePicture(sender: AnyObject) {

        println("Button capture")
        
        var imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePickerController.allowsEditing = true
        
        self.presentViewController(imagePickerController, animated: true, completion: { imageP in
        })
    }
    @IBOutlet var nameField: UITextField
    
    @IBOutlet var notesField: UITextField
    
    @IBAction func save() {
        bar.name = nameField.text
        bar.notes = notesField.text
//        println(nameField.text)
        masterViewController?.addBar(bar)

    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        bar.picture = image
        barPicturePreview.image = bar.picture
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
