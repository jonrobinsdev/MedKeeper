//
//  AlarmsViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/4/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit
import CoreData

class AlarmsViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, MedicineHeaderCustomCellDelegate {

    @IBOutlet var alarmsTableView: UITableView!
    var medicineArray: NSArray = [NSManagedObject]()
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
        
        //if first time using app, demand name for patient profile
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
            navigationItem.title = (defaults.valueForKey("CurrentUser") as! String) + "'s Medicines"
            defaults.synchronize()
            //user has already launched app before and made an initial profile
        }
        
        alarmsTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        //retrieve all the medicines in core data
        let fetchRequest = NSFetchRequest(entityName: "Medicine")
        do {
            let results =
            try managedObjectContext.executeFetchRequest(fetchRequest)
            medicineArray = results as! [NSManagedObject]
            //sort Medicines alphabetically
            medicineArray = medicineArray.sort({ $0.name.lowercaseString < $1.name.lowercaseString })
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
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
        //save initial patient profile if user's first time using app, set as CurrentUser
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(1, forKey: "FirstTimeLaunchingApp")
        defaults.setValue(name, forKey: "CurrentUser")
        navigationItem.title = (name as String) + "'s Medicines"
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
        let medicine : Medicine = medicineArray[section] as! Medicine
        let alarms : NSSet = medicine.alarms
        if(alarms.count > 0){
            return alarms.count
        }
        else{
            return 1
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 37
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: AlarmsCustomCell! = tableView.dequeueReusableCellWithIdentifier("alarmcustomcell") as? AlarmsCustomCell
        if(cell == nil) {
            tableView.registerNib(UINib(nibName: "AlarmsCustomCell", bundle: nil), forCellReuseIdentifier: "alarmcustomcell")
            cell = tableView.dequeueReusableCellWithIdentifier("alarmcustomcell") as? AlarmsCustomCell
        }
        //get medicine at indexPath and assign its alarm's properties to alarm cell
        let medicine : Medicine = medicineArray[indexPath.section] as! Medicine
        let alarms : NSArray = medicine.alarms.allObjects
        if(alarms.count > 0){
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            let alarm : Alarm = alarms[indexPath.row] as! Alarm
            cell.alarmTime.text = String(dateFormatter.stringFromDate(alarm.time!))
            cell.weekdays.text = alarm.weekdays
            cell.textLabel?.backgroundColor = UIColor.clearColor()
        }
        else{
            var cell: NoAlarmsCustomCell! = tableView.dequeueReusableCellWithIdentifier("noalarmscustomcell") as? NoAlarmsCustomCell
            if(cell == nil) {
                tableView.registerNib(UINib(nibName: "NoAlarmsCustomCell", bundle: nil), forCellReuseIdentifier: "noalarmscustomcell")
                cell = tableView.dequeueReusableCellWithIdentifier("noalarmscustomcell") as? NoAlarmsCustomCell
            }
            return cell
            //cell.imageView.image = imagewithnameblahblah
        }
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var cell: MedicineHeaderCustomCell! = tableView.dequeueReusableCellWithIdentifier("headercustomcell") as? MedicineHeaderCustomCell
        if(cell == nil) {
            tableView.registerNib(UINib(nibName: "MedicineHeaderCustomCell", bundle: nil), forCellReuseIdentifier: "headercustomcell")
            cell = tableView.dequeueReusableCellWithIdentifier("headercustomcell") as? MedicineHeaderCustomCell
        }
        //assign medicine data object at index to medicine section cell
        let medicine = medicineArray[section]
        cell.medicineNameLabel.text = medicine.valueForKey("name") as? String
        cell.dosageLabel.text = medicine.valueForKey("dosage") as? String
        cell.medicineType = medicine.type
        if(medicine.type == "Liquid"){
            cell.medicineImage.image = UIImage(named: "liquidIcon.png")
        }
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view:UIView = UIView.init(frame: CGRectMake(0, 0, alarmsTableView.frame.size.width, 50))
        view.backgroundColor = UIColor.darkGrayColor()
        return view
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func didSelectUserHeaderTableViewCell(Selected: Bool, UserHeader: MedicineHeaderCustomCell) {
        //save header's medicine name as current medicine
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(UserHeader.medicineNameLabel.text, forKey: "CurrentMedicine")
        performSegueWithIdentifier("segueToMedicineDetail", sender: self)
    }

}

