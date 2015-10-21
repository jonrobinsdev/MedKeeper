//
//  AddReminderViewController5a.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/5/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

protocol AlarmCustomCellDelegate {
    func deleteButtonPressed(cell: AlarmCustomCell)
}

class AddReminderViewController5a: UIViewController, UITableViewDelegate, UITableViewDataSource, AlarmCustomCellDelegate {
    
    @IBOutlet var addAlarmButton: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var alarmTableView: UITableView!
    var alarmList: NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alarmTableView.delegate = self
        self.alarmTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addAlarmButtonPressed(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let alarmValue = dateFormatter.stringFromDate(self.datePicker.date)

        self.alarmList.insertObject(alarmValue, atIndex: self.alarmList.count)
        self.alarmTableView.reloadData()
        
        let indexPath = NSIndexPath(forRow: alarmList.count-1, inSection: 0)
        self.alarmTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmList.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var cell: AlarmCustomCell! = tableView.dequeueReusableCellWithIdentifier("alarmCustomCell") as? AlarmCustomCell
            if(cell == nil) {
                tableView.registerNib(UINib(nibName: "AlarmCustomCell", bundle: nil), forCellReuseIdentifier: "alarmCustomCell")
                cell = tableView.dequeueReusableCellWithIdentifier("alarmCustomCell") as? AlarmCustomCell
            }
            cell.textLabel!.text = alarmList[indexPath.row] as? String
            cell.delegate = self;
            return cell
    }
    
    func deleteButtonPressed(cell: AlarmCustomCell){
        let indexPath: NSIndexPath = self.alarmTableView.indexPathForCell(cell)!
        self.alarmList.removeObjectAtIndex(indexPath.row)
        self.alarmTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
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
