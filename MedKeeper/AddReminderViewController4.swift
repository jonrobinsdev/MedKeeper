//
//  AddReminderViewController4.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/5/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class AddReminderViewController4: UIViewController{
    
    @IBOutlet private var normalAlarmButton: UIButton!
    @IBOutlet private var intervalAlarmButton: UIButton!
    private var alarmType = "Normal";
    
    override func viewDidLoad() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func normalAlarmButtonPressed(sender: AnyObject) {
        self.alarmType = "Normal"
    }
    
    @IBAction func intervalAlarmButtonPressed(sender: AnyObject) {
        self.alarmType = "Interval"
    }
    
    internal func getAlarmType() -> String{
        return self.alarmType
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
