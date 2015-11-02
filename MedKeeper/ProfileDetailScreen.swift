//
//  ProfileDetailScreen.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/22/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class ProfileDetailScreen: UIViewController {

    @IBOutlet var profileName: UILabel!
    var incomingName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = self.incomingName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
