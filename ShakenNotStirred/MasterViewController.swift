//
//  MasterViewController.swift
//  ShakenNotStirred
//
//  Created by Johannes Würbach on 7/12/14.
//  Copyright (c) 2014 Slugfest. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Bar]()

    @IBOutlet var barTableView: UITableView

    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        //let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        //self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        let alert = UIAlertController(title: "New Task",
            message: "",
            preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "Local edition"
        }
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { action in
                alert.dismissViewControllerAnimated(true) {}
        }
        alert.addAction(cancelAction)
        let createAction = UIAlertAction(title: "Create",
            style: .Default) { action in
                let textField = alert.textFields[0] as UITextField
                self.addBar(Bar(name: textField.text, notes: "Some notes"))
        }
        alert.addAction(createAction)
        presentViewController(alert, animated: true) {}
    }
    
    func insertBar(bar: Bar) {
        objects.append(bar)
    }
    
    func addBar(bar: Bar) {
        objects += bar
        let indexPath = NSIndexPath(forRow: objects.count - 1, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // #pragma mark - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let object = objects[indexPath.row]
            ((segue.destinationViewController as UINavigationController).topViewController as DetailViewController).bar = object
        } else if segue.identifier == "Add" {
            var viewController = segue.destinationViewController as AddViewController
            viewController.masterViewController = self
        }
    }

    // #pragma mark - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let object = objects[indexPath.row]
        cell.textLabel.text = object.description
        cell.imageView.image = object.picture
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            let object = objects[indexPath.row]
            self.detailViewController!.bar = object
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    func viewDidAppear() {
        becomeFirstResponder()
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent!) {
        if (motion == UIEventSubtype.MotionShake)
        {
            // User was shaking the device. Post a notification named "shake."
            let randomBarIndex = Int(arc4random_uniform(UInt32(objects.count)))
            let object = objects[randomBarIndex]
            self.detailViewController!.bar = object
            
            NSLog("load random bar %i", randomBarIndex)
            
            let indexPath = NSIndexPath(forRow: randomBarIndex, inSection: 0)
            barTableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
            
            performSegueWithIdentifier("showDetail", sender: self)
            
        }
    }

}

