//
//  AlarmsViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/4/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit
import CoreData

class AlarmsViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var alarmsTableView: UITableView!
    var medicineArray: NSArray = [NSManagedObject]()
    var alarmsArray: NSArray = [NSManagedObject]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action:"addButtonPressed")
        navigationItem.rightBarButtonItem = addButton
        
        alarmsTableView.delegate = self
        alarmsTableView.dataSource = self
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.integerForKey("FirstTimeLaunchingApp") != 1){
            //initial alertView
            var tField: UITextField!
            func configurationTextField(textField: UITextField!)
            {
                textField.returnKeyType = UIReturnKeyType.Done
                tField = textField
                tField.delegate = self
            }
            let alert = UIAlertController(title: "Please Enter A Name For Your Patient Profile", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addTextFieldWithConfigurationHandler(configurationTextField)
            //this action is necessary for some reason or else keyboard doesn't dismiss correctly
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:nil))
            self.presentViewController(alert, animated: true, completion: {
                print("First time alert view appeared!")
            })
        }
        else{
            //user has already launched app before and made an initial profile
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        let fetchRequest = NSFetchRequest(entityName: "Medicine")
        do {
            let results =
            try managedObjectContext.executeFetchRequest(fetchRequest)
            medicineArray = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        alarmsTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField.text?.characters.count > 0){
            saveInitialPatientProfile(textField.text!)
            return true
        }
        else{
            return false
        }
    }
    
    func addButtonPressed(){
        performSegueWithIdentifier("addMedicineSegue", sender: self)
    }
    
    func saveInitialPatientProfile(name : NSString){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(1, forKey: "FirstTimeLaunchingApp")
        defaults.setValue(name, forKey: "CurrentUser")
        defaults.synchronize()
        
        let managedContext = AppDelegate().managedObjectContext
        let entity =  NSEntityDescription.entityForName("PatientProfile", inManagedObjectContext: managedContext)
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        person.setValue(name, forKey: "name")
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return medicineArray.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 37
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var cell: AlarmsCustomCell! = tableView.dequeueReusableCellWithIdentifier("alarmcustomcell") as? AlarmsCustomCell
            if(cell == nil) {
                tableView.registerNib(UINib(nibName: "AlarmsCustomCell", bundle: nil), forCellReuseIdentifier: "alarmcustomcell")
                cell = tableView.dequeueReusableCellWithIdentifier("alarmcustomcell") as? AlarmsCustomCell
            }
            //cell.nameLabel.text = "lol"
            cell.textLabel?.backgroundColor = UIColor.clearColor()
            return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var cell: MedicineHeaderCustomCell! = tableView.dequeueReusableCellWithIdentifier("headercustomcell") as? MedicineHeaderCustomCell
        if(cell == nil) {
            tableView.registerNib(UINib(nibName: "MedicineHeaderCustomCell", bundle: nil), forCellReuseIdentifier: "headercustomcell")
            cell = tableView.dequeueReusableCellWithIdentifier("headercustomcell") as? MedicineHeaderCustomCell
        }
        let medicine = medicineArray[section]
        cell.medicineNameLabel.text = medicine.valueForKey("name") as? String
        cell.dosageLabel.text = "5 mg"
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
}

