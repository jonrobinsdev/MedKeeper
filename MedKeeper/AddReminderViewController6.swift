//
//  AddReminderViewController6.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/5/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class AddReminderViewController6: UIViewController {
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        yesButton.layer.cornerRadius = yesButton.frame.size.height/4
        noButton.layer.cornerRadius = noButton.frame.size.height/4
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
