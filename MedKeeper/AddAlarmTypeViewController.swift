//
//  AddAlarmTypeViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 11/7/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class AddAlarmTypeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add an Alarm"
        let backButton = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
}
