//
//  AddNormalAlarmViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 11/8/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit
import CoreData

class AddNormalAlarmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NormalAlarmCustomCellDelegate{
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var alarmTableView: UITableView!
    var alarmList: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add Normal Alarms"
        let backButton = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: Selector("doneButtonPressed"))
        navigationItem.rightBarButtonItem = doneButton


        alarmTableView.delegate = self
        alarmTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addAlarmButtonPressed(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let alarmValue:NSDate = datePicker.date
        
        if(alarmList.containsObject(alarmValue)){
            let alert = UIAlertController(title: "Duplicate Alarm", message: "You've already added an alarm for that time.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            alarmList.insertObject(alarmValue, atIndex: alarmList.count)
            alarmTableView.reloadData()
            let indexPath = NSIndexPath(forRow: alarmList.count-1, inSection: 0)
            alarmTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        }
    }
    
    func doneButtonPressed(){
        if(alarmList.count > 0){
            //save alarms to current medicine
            let managedContext = AppDelegate().managedObjectContext
            //get name of current medicine
            let defaults = NSUserDefaults.standardUserDefaults()
            let currentMedicine : String = defaults.valueForKey("CurrentMedicine") as! String
            //fetch for all medicines with name of currentMedicine
            let predicate = NSPredicate(format: "name == %@", currentMedicine)
            let fetchRequest = NSFetchRequest(entityName: "Medicine")
            fetchRequest.predicate = predicate
            var fetchedCurrentMedicine:Medicine!
            do {
                let fetchedMedicines = try managedContext.executeFetchRequest(fetchRequest) as! [Medicine]
                fetchedCurrentMedicine = fetchedMedicines.first
            } catch {
                
            }
            
            //add all the alarms to the Medicine class
            for alarmString in alarmList{
                let entity =  NSEntityDescription.entityForName("Alarm", inManagedObjectContext: managedContext)
                let alarm = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Alarm
                alarm.setValue("MWF", forKey: "weekdays")
                alarm.setValue(alarmString, forKey: "time")
                fetchedCurrentMedicine.addAlarmObject(alarm)
            }

            do {
                try managedContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            //go back to alarm timeline
            navigationController?.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "No Alarms Set", message: "You haven't set any alarms for this medication.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmList.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var cell: NormalAlarmCustomCell! = tableView.dequeueReusableCellWithIdentifier("normalAlarmCustomCell") as? NormalAlarmCustomCell
            if(cell == nil) {
                tableView.registerNib(UINib(nibName: "NormalAlarmCustomCell", bundle: nil), forCellReuseIdentifier: "normalAlarmCustomCell")
                cell = tableView.dequeueReusableCellWithIdentifier("normalAlarmCustomCell") as? NormalAlarmCustomCell
            }
            cell.textLabel!.text = alarmList[indexPath.row] as? String
            cell.delegate = self;
            return cell
    }
    
    func deleteButtonPressed(cell: NormalAlarmCustomCell){
        let indexPath: NSIndexPath = alarmTableView.indexPathForCell(cell)!
        alarmList.removeObjectAtIndex(indexPath.row)
        alarmTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
