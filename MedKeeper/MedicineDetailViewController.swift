//
//  MedicineDetailViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 11/6/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit
import CoreData

class MedicineDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    @IBOutlet var medicineDetailTableView: UITableView!
    @IBOutlet var medicineImage: UIImageView!
    var fetchedCurrentMedicine : Medicine!
    var fetchedAlarms: NSArray!
    var medicineName : String = ""
    var medicineType : String = ""
    var dosageAmount : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        medicineDetailTableView.delegate = self
        medicineDetailTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let currentMedicine:String = defaults.valueForKey("CurrentMedicine") as! String
        let currentUser:String = defaults.valueForKey("CurrentUser") as! String
        let predicate = NSPredicate(format: "name == %@", currentUser)
        let fetchRequest = NSFetchRequest(entityName: "PatientProfile")
        fetchRequest.predicate = predicate
        var fetchedCurrentUser:PatientProfile!
        do {
            let fetchedProfiles = try managedObjectContext.executeFetchRequest(fetchRequest) as! [PatientProfile]
            fetchedCurrentUser = fetchedProfiles.first
        } catch {
        }
        for object in fetchedCurrentUser.medicines!{
            let medicine:Medicine = object as! Medicine
            if(medicine.name == currentMedicine){
                fetchedCurrentMedicine = medicine
                medicineName = fetchedCurrentMedicine.name!
                medicineType = fetchedCurrentMedicine.type!
                dosageAmount = fetchedCurrentMedicine.dosage!
                navigationItem.title = medicineName
            }
        }
        
        medicineDetailTableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            if(fetchedCurrentMedicine.alarms.count > 0){
                return fetchedCurrentMedicine.alarms.count
            }
            else{
                return 1
            }
        case 5:
            return 1
        case 6:
            return 1
        default:
            break
        }
        return 0
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return ""
        case 1:
            return "Medicine Name"
        case 2:
            return "Medicine Type"
        case 3:
            return "Dosage Amount"
        case 4:
            return "Alarms"
        case 5:
            return ""
        case 6:
            return ""
        default:
            break
        }
        return "Error"
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return 145
        }
        return 37
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            var cell: MedicineImageCustomCell! = tableView.dequeueReusableCellWithIdentifier("medicineimagecustomcell") as? MedicineImageCustomCell
            if(cell == nil) {
                tableView.registerNib(UINib(nibName: "MedicineImageCustomCell", bundle: nil), forCellReuseIdentifier: "medicineimagecustomcell")
                cell = tableView.dequeueReusableCellWithIdentifier("medicineimagecustomcell") as? MedicineImageCustomCell
            }
            return cell
        }
        else if(indexPath.section == 4){
            if(fetchedCurrentMedicine.alarms.count > 0){
                var cell: NormalAlarmCustomCell! = tableView.dequeueReusableCellWithIdentifier("normalalarmcustomcell") as? NormalAlarmCustomCell
                if(cell == nil) {
                    tableView.registerNib(UINib(nibName: "NormalAlarmCustomCell", bundle: nil), forCellReuseIdentifier: "normalalarmcustomcell")
                    cell = tableView.dequeueReusableCellWithIdentifier("normalalarmcustomcell") as? NormalAlarmCustomCell
                }
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
                dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
                //let alarm:Alarm =  fetchedAlarms[indexPath.row] as! Alarm
                //print(alarm.time)
                return cell
            }
            else{
            }
        }
        else if(indexPath.section == 5){
            var cell: MedicineAddAlarmButtonCell! = tableView.dequeueReusableCellWithIdentifier("medicineaddalarmbuttoncell") as? MedicineAddAlarmButtonCell
            if(cell == nil) {
                tableView.registerNib(UINib(nibName: "MedicineAddAlarmButtonCell", bundle: nil), forCellReuseIdentifier: "medicineaddalarmbuttoncell")
                cell = tableView.dequeueReusableCellWithIdentifier("medicineaddalarmbuttoncell") as? MedicineAddAlarmButtonCell
                cell.addAlarmsButton.addTarget(self, action: Selector("addAlarmCellPressed"), forControlEvents: .TouchUpInside)
            }
            return cell
        }
        else if(indexPath.section == 6){
            var cell: MedicineDeleteButtonCell! = tableView.dequeueReusableCellWithIdentifier("medicinedeletebuttoncell") as? MedicineDeleteButtonCell
            if(cell == nil) {
                tableView.registerNib(UINib(nibName: "MedicineDeleteButtonCell", bundle: nil), forCellReuseIdentifier: "medicinedeletebuttoncell")
                cell = tableView.dequeueReusableCellWithIdentifier("medicinedeletebuttoncell") as? MedicineDeleteButtonCell
            }
            cell.deleteButton.addTarget(self, action: Selector("deleteCurrentMedicine"), forControlEvents: .TouchUpInside)
            return cell
        }
        var cell: MedicineDetailCustomCell! = tableView.dequeueReusableCellWithIdentifier("medicinedetailcustomcell") as? MedicineDetailCustomCell
        if(cell == nil) {
            tableView.registerNib(UINib(nibName: "MedicineDetailCustomCell", bundle: nil), forCellReuseIdentifier: "medicinedetailcustomcell")
            cell = tableView.dequeueReusableCellWithIdentifier("medicinedetailcustomcell") as? MedicineDetailCustomCell
        }
        cell.textField.delegate = self
        switch indexPath.section{
        case 1:
            cell.textField.text = medicineName
        case 2:
            cell.textField.text = medicineType
        case 3:
            cell.textField.text = dosageAmount
        default:
            break
        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    func addAlarmCellPressed(){
        performSegueWithIdentifier("detailToAddAlarmSegue", sender: self)
    }
    
    func deleteCurrentMedicine(){
        let defaults = NSUserDefaults.standardUserDefaults()
        let currentUser:String = defaults.valueForKey("CurrentUser") as! String
        let predicate = NSPredicate(format: "name == %@", currentUser)
        let fetchRequest = NSFetchRequest(entityName: "PatientProfile")
        fetchRequest.predicate = predicate
        var fetchedCurrentUser:PatientProfile!
        do {
            let fetchedProfiles = try managedObjectContext.executeFetchRequest(fetchRequest) as! [PatientProfile]
            fetchedCurrentUser = fetchedProfiles.first
        } catch {
        }
        fetchedCurrentUser.removeMedicineObject(fetchedCurrentMedicine)
        managedObjectContext.deleteObject(fetchedCurrentMedicine)
        do {
            try managedObjectContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        navigationController?.popToRootViewControllerAnimated(true)
    }
}
