//
//  AddReminderViewController6.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/5/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class AddReminderViewController6: UIViewController {
    
    @IBOutlet var sundayButton: UIButton!
    @IBOutlet var mondayButton: UIButton!
    @IBOutlet var tuesdayButton: UIButton!
    @IBOutlet var wednesdayButton: UIButton!
    @IBOutlet var thursdayButton: UIButton!
    @IBOutlet var fridayButton: UIButton!
    @IBOutlet var saturdayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func weekdayButtonPressed(button: UIButton) {
        let selectedColor: UIColor = UIColor(red: 0.0/255.0, green: 87.0/255.0, blue: 170/255.0, alpha: 1.0)
        let unselectedColor : UIColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255/255.0, alpha: 1.0)

        if(button.tag == 1){
            button.tag = 0
            button.backgroundColor = unselectedColor
        }
        else{
            button.tag = 1
            button.backgroundColor = selectedColor
        }
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
