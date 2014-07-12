//
//  DetailViewController.swift
//  ShakenNotStirred
//
//  Created by Johannes Würbach on 7/12/14.
//  Copyright (c) 2014 Slugfest. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UISplitViewControllerDelegate {

    var masterPopoverController: UIPopoverController? = nil

    @IBOutlet var pictureView: UIImageView
    @IBOutlet var viewTitle: UINavigationItem
    @IBOutlet var barNotes: UITextView

    var bar: Bar? {
        didSet {
            // Update the view.
            self.configureView()

            if self.masterPopoverController != nil {
                self.masterPopoverController!.dismissPopoverAnimated(true)
            }
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.bar {
            if let textView = self.barNotes {
                textView.text = detail.notes
            }
            
            if let viewTitle = self.viewTitle {
                viewTitle.title = detail.name
            }
            
            if let pictureView = self.pictureView {
                pictureView.image = detail.picture
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Split view

    func splitViewController(splitController: UISplitViewController, willHideViewController viewController: UIViewController, withBarButtonItem barButtonItem: UIBarButtonItem, forPopoverController popoverController: UIPopoverController) {
        barButtonItem.title = "Bars" // NSLocalizedString(@"Master", @"Master")
        self.navigationItem.setLeftBarButtonItem(barButtonItem, animated: true)
        self.masterPopoverController = popoverController
    }

    func splitViewController(splitController: UISplitViewController, willShowViewController viewController: UIViewController, invalidatingBarButtonItem barButtonItem: UIBarButtonItem) {
        // Called when the view is shown again in the split view, invalidating the button and popover controller.
        self.navigationItem.setLeftBarButtonItem(nil, animated: true)
        self.masterPopoverController = nil
    }
    func splitViewController(splitController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return true
    }

}

