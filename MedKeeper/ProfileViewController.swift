//
//  FirstViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/4/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet var profilesTableView: UITableView!
    var profileArray: NSArray = [NSManagedObject]()
    var selectedCellName : String = "";
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profilesTableView.delegate = self
        self.profilesTableView.dataSource = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest = NSFetchRequest(entityName: "PatientProfile")
        do {
            let results =
            try managedObjectContext.executeFetchRequest(fetchRequest)
            profileArray = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var cell: ProfileCustomCell! = tableView.dequeueReusableCellWithIdentifier("profileCustomCell") as? ProfileCustomCell
            if(cell == nil) {
                tableView.registerNib(UINib(nibName: "ProfileCustomCell", bundle: nil), forCellReuseIdentifier: "profileCustomCell")
                cell = tableView.dequeueReusableCellWithIdentifier("profileCustomCell") as? ProfileCustomCell
            }
            let patientProfile = profileArray[indexPath.row]
            cell.nameLabel.text = patientProfile.valueForKey("name") as? String
            cell.textLabel?.backgroundColor = UIColor.clearColor()
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.profileArray[indexPath.row], forKey: "CurrentUser")*/
        
        /*let tabBar = self.tabBarController
        tabBar!.selectedIndex = 1;*/
        
        let patientProfile = profileArray[indexPath.row]
        self.selectedCellName = (patientProfile.valueForKey("name") as? String)!
        self.performSegueWithIdentifier("profileCellToDetailedProfileVC", sender: self)
    }

    @IBAction func addProfileButtonPressed(sender: AnyObject) {
        var tField: UITextField!
        func configurationTextField(textField: UITextField!)
        {
            textField.returnKeyType = UIReturnKeyType.Done
            tField = textField
            tField.delegate = self
        }
        let alert = UIAlertController(title: "Please Enter A Name For Your New Patient Profile", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        //this action is necessary for some reason or else keyboard doesn't dismiss correctly
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(alert, animated: true, completion: {
            print("New profile alert view appeared!")
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField.text?.characters.count > 0){
            saveNewPatientProfile(textField.text!)
            return true
        }
        else{
            return false
        }
    }
    
    func saveNewPatientProfile(name : NSString){
        //save patient profile
        let newPatientProfile = NSEntityDescription.insertNewObjectForEntityForName("PatientProfile", inManagedObjectContext: self.managedObjectContext) as! PatientProfile
        newPatientProfile.name = name as String
        do{
            try self.managedObjectContext.save()
        } catch let error as NSError{
            print(error)
        }
        
        /*let managedContext = AppDelegate().managedObjectContext
        let entity =  NSEntityDescription.entityForName("PatientProfile", inManagedObjectContext: managedContext)
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        person.setValue(name, forKey: "name")
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }*/
        
        //set new profile array and reload table data
        let fetchRequest = NSFetchRequest(entityName: "PatientProfile")
        do {
            let results =
            try self.managedObjectContext.executeFetchRequest(fetchRequest)
            profileArray = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        self.profilesTableView.reloadData()
        
        let indexPath = NSIndexPath(forRow: self.profileArray.count-1, inSection: 0)
        self.profilesTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let destVC : ProfileDetailScreen = (segue.destinationViewController as? ProfileDetailScreen)!
        destVC.incomingName = self.selectedCellName
    }
}

