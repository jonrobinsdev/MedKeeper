//
//  FirstViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/4/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet var profilesTableView: UITableView!
    var profileArray: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        profileArray = defaults.objectForKey("ProfileArray") as! NSMutableArray
        
        self.profilesTableView.delegate = self
        self.profilesTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75;
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var cell: ProfileCustomCell! = tableView.dequeueReusableCellWithIdentifier("profileCustomCell") as? ProfileCustomCell
            if(cell == nil) {
                tableView.registerNib(UINib(nibName: "ProfileCustomCell", bundle: nil), forCellReuseIdentifier: "profileCustomCell")
                cell = tableView.dequeueReusableCellWithIdentifier("profileCustomCell") as? ProfileCustomCell
            }
            cell.nameLabel.text = profileArray[indexPath.row] as? String
            cell.textLabel?.backgroundColor = UIColor.clearColor()
            return cell
    }

    @IBAction func addProfileButtonPressed(sender: AnyObject) {
        var tField: UITextField!
        func configurationTextField(textField: UITextField!)
        {
            textField.returnKeyType = UIReturnKeyType.Done
            tField = textField
            tField.delegate = self
        }
        let alert = UIAlertController(title: "Please Enter A Name For Your New Medicine Profile", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        //this action is necessary for some reason or else keyboard doesn't dismiss correctly
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(alert, animated: true, completion: {
            print("New profile alert view appeared!")
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField.text?.characters.count > 0){
            saveNewProfileNameToNSUserDefaults(textField.text!)
            return true
        }
        else{
            return false
        }
    }
    
    func saveNewProfileNameToNSUserDefaults(name : NSString){
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let tempNewProfileArray : NSMutableArray = defaults.objectForKey("ProfileArray") as! NSMutableArray
        let newProfileArray : NSMutableArray = []
        
        for var i = 0; i < tempNewProfileArray.count; i++ {
            newProfileArray.insertObject(tempNewProfileArray[i], atIndex: i)
        }
        
        newProfileArray.insertObject(name, atIndex: newProfileArray.count)
        
        defaults.setObject(newProfileArray, forKey: "ProfileArray")
        defaults.synchronize()
        
        self.profileArray = newProfileArray
        self.profilesTableView.reloadData()
        
        let indexPath = NSIndexPath(forRow: self.profileArray.count-1, inSection: 0)
        self.profilesTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
}

