//
//  SecondViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/4/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class AlarmsViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.objectForKey("ProfileArray") == nil || defaults.integerForKey("FirstTimeLaunchingApp") != 1){
            
            //initial alertView
            var tField: UITextField!
            func configurationTextField(textField: UITextField!)
            {
                textField.returnKeyType = UIReturnKeyType.Done
                tField = textField
                tField.delegate = self
            }
            let alert = UIAlertController(title: "Please Enter A Name For Your Medicine Profile", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addTextFieldWithConfigurationHandler(configurationTextField)
            //this action is necessary for some reason or else keyboard doesn't dismiss correctly
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:nil))
            self.presentViewController(alert, animated: true, completion: {
                print("First time alert view appeared!")
            })
        }
        else{
            let profileArray : NSMutableArray = defaults.objectForKey("ProfileArray") as! NSMutableArray
            print(profileArray)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField.text?.characters.count > 0){
            saveInitialProfileNameToNSUserDefaults(textField.text!)
            return true
        }
        else{
            return false
        }
    }
    
    func saveInitialProfileNameToNSUserDefaults(name : NSString){
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setInteger(1, forKey: "FirstTimeLaunchingApp")
        
        let profileArray : NSMutableArray = []
        profileArray.insertObject(name, atIndex: 0)
        
        defaults.setValue(name, forKey: "CurrentUser")
        defaults.setObject(profileArray, forKey: "ProfileArray")
        
        defaults.synchronize()
    }
}

