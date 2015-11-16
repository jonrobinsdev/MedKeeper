//
//  AddMedicineNameAndTypeViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 11/2/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit
import CoreData

class AddMedicineNameAndTypeViewController: UIViewController {
    
    @IBOutlet var medicineNameTextField: UITextField!
    @IBOutlet var typeSegmentController: UISegmentedControl!
    var currentSegmentControlIndex = 0;
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Add a Medication"
        
        medicineNameTextField.becomeFirstResponder()
        
        let backButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action:"cancelButtonPressed")
        navigationItem.leftBarButtonItem = backButton
        
        let nextButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: Selector("nextButtonPressed"))
        navigationItem.rightBarButtonItem = nextButton
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextButtonPressed(){
        //check that textfield isnt blank
        if(medicineNameTextField.text == ""){
            let alert = UIAlertController(title: "Please enter a Medicine name.", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            //check that this medicine name hasnt been registered before
            let fetchRequest = NSFetchRequest(entityName: "Medicine")
            var nameNotTaken:Bool = true
            do {
                let results =
                try managedObjectContext.executeFetchRequest(fetchRequest)
                let medicineArray:NSArray = results as! [NSManagedObject]
                for medicine in medicineArray{
                    let fetchedMedicine = medicine as! Medicine
                    if(fetchedMedicine.name == medicineNameTextField.text){
                        let alert = UIAlertController(title: "Medicine name already taken!", message: "Please enter a different medicine name.", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        nameNotTaken = false
                    }
                }
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
            if(nameNotTaken){
                performSegueWithIdentifier("segueToDosage", sender: self)
            }
        }
    }
    
    func cancelButtonPressed(){
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func segmentedControlChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentSegmentControlIndex = 0
        case 1:
            currentSegmentControlIndex = 1
        default:
            break;
        
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let destVC : AddMedicineDosageViewController = (segue.destinationViewController as? AddMedicineDosageViewController)!
        if(currentSegmentControlIndex == 0){
            destVC.setType("Pill")
        }
        else{
            destVC.setType("Liquid")
        }
        destVC.retrievedName = medicineNameTextField.text as String!
        print(destVC.retrievedName)
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
