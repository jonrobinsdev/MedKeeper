//
//  SettingsTableViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 11/15/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return 145
        }
        else{
            return 37
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Patient Profile Image"
        case 1:
            return "Patient Profile Name"
        case 2:
            return "Delete Patient Profile"
        default:
            return "what"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: SettingsProfileImageCustomCell! = tableView.dequeueReusableCellWithIdentifier("settingsprofileimagecustomcell") as? SettingsProfileImageCustomCell
        if(cell == nil) {
            tableView.registerNib(UINib(nibName: "SettingsProfileImageCustomCell", bundle: nil), forCellReuseIdentifier: "settingsprofileimagecustomcell")
            cell = tableView.dequeueReusableCellWithIdentifier("settingsprofileimagecustomcell") as? SettingsProfileImageCustomCell
        }
        
        if(indexPath.section == 1){
            var cell: MedicineDetailCustomCell! = tableView.dequeueReusableCellWithIdentifier("medicinedetailcustomcell") as? MedicineDetailCustomCell
            if(cell == nil) {
                tableView.registerNib(UINib(nibName: "MedicineDetailCustomCell", bundle: nil), forCellReuseIdentifier: "medicinedetailcustomcell")
                cell = tableView.dequeueReusableCellWithIdentifier("medicinedetailcustomcell") as? MedicineDetailCustomCell
            }
                return cell
        }
        else if (indexPath.section == 2){
            var cell: SettingsProfileDeleteCustomCell! = tableView.dequeueReusableCellWithIdentifier("settingsprofiledeletecustomcell") as? SettingsProfileDeleteCustomCell
            if(cell == nil) {
                tableView.registerNib(UINib(nibName: "SettingsProfileDeleteCustomCell", bundle: nil), forCellReuseIdentifier: "settingsprofiledeletecustomcell")
                cell = tableView.dequeueReusableCellWithIdentifier("settingsprofiledeletecustomcell") as? SettingsProfileDeleteCustomCell
                return cell
                }
        }
        return cell
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
