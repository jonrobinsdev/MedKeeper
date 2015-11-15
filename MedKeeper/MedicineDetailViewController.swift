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
    
    @IBOutlet var medicineDetailTableView: UITableView!
    @IBOutlet var medicineImage: UIImageView!
    var fetchedCurrentMedicine : Medicine!
    var medicineName : String = ""
    var medicineType : String = ""
    var dosageAmount : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        medicineDetailTableView.delegate = self
        medicineDetailTableView.dataSource = self
        
        navigationItem.title = medicineName
    }
    
    override func viewWillAppear(animated: Bool) {
        let managedContext = AppDelegate().managedObjectContext
        let defaults = NSUserDefaults.standardUserDefaults()
        let currentMedicine:String = defaults.valueForKey("CurrentMedicine") as! String
        let predicate = NSPredicate(format: "name == %@", currentMedicine)
        let fetchRequest = NSFetchRequest(entityName: "Medicine")
        fetchRequest.predicate = predicate
        do {
            let fetchedMedicines = try managedContext.executeFetchRequest(fetchRequest) as! [Medicine]
            fetchedCurrentMedicine = fetchedMedicines.first
        } catch {
        }
        
        medicineName = fetchedCurrentMedicine.name!
        medicineType = fetchedCurrentMedicine.type!
        dosageAmount = fetchedCurrentMedicine.dosage!
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
            var cell: NormalAlarmCustomCell! = tableView.dequeueReusableCellWithIdentifier("normalalarmcustomcell") as? NormalAlarmCustomCell
            if(cell == nil) {
                tableView.registerNib(UINib(nibName: "NormalAlarmCustomCell", bundle: nil), forCellReuseIdentifier: "normalalarmcustomcell")
                cell = tableView.dequeueReusableCellWithIdentifier("normalalarmcustomcell") as? NormalAlarmCustomCell
            }
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

}
