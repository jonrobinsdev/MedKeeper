//
//  AddNewProfileViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 11/15/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit
import CoreData

class AddNewProfileViewController: UIViewController {
    
    @IBOutlet var newProfileTextField: UITextField!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()

        newProfileTextField.becomeFirstResponder()
        
        navigationItem.title = "Add a New Profile"
        
        let backButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action:"cancelButtonPressed")
        navigationItem.leftBarButtonItem = backButton
        let nextButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: Selector("doneButtonPressed"))
        navigationItem.rightBarButtonItem = nextButton

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cancelButtonPressed(){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func doneButtonPressed(){
        //check that this profile name hasnt been registered before
        let fetchRequest = NSFetchRequest(entityName: "PatientProfile")
        var nameNotTaken:Bool = true
        do {
            let results =
            try managedObjectContext.executeFetchRequest(fetchRequest)
            let profileArray:NSArray = results as! [NSManagedObject]
            for profile in profileArray{
                let fetchedProfile = profile as! PatientProfile
                if(fetchedProfile.name == newProfileTextField.text){
                    let alert = UIAlertController(title: "Profile name already taken!", message: "Please enter a different profile name.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    nameNotTaken = false
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        if(nameNotTaken){
            //save patient profile
            let newPatientProfile = NSEntityDescription.insertNewObjectForEntityForName("PatientProfile", inManagedObjectContext: self.managedObjectContext) as! PatientProfile
            newPatientProfile.name = newProfileTextField.text
            do{
                try self.managedObjectContext.save()
                self.navigationController?.popToRootViewControllerAnimated(true)
            } catch let error as NSError{
                print(error)
            }
            
            /*//set new profile array and reload table data
            let fetchRequest = NSFetchRequest(entityName: "PatientProfile")
            do {
                let results =
                try self.managedObjectContext.executeFetchRequest(fetchRequest)
                profileArray = results as! [NSManagedObject]
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
            self.profilesTableView.reloadData()
            
            let indexPath = NSIndexPath(forRow: self.profileArray.count-1, inSection: 0)
            self.profilesTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)*/
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
