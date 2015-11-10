//
//  AddMedicineDosageViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 11/2/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit
import CoreData

class AddMedicineDosageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var dosagePickerView: UIPickerView!
    @IBOutlet var dosageAmount: UITextField!
    var medicineType: String = "Pill"
    private var pillPickerViewData = ["Pills", "mg"]
    private var liquidPickerViewData = ["Tbsp", "tsp", "mL"]
    private var currentMeasurement = "Pills"
    var retrievedName : String  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Enter Dosage"
        dosageAmount.keyboardType = .DecimalPad
        dosageAmount.becomeFirstResponder()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: Selector("doneButtonPressed"))
        navigationItem.rightBarButtonItem = doneButton
        
        dosageAmount.delegate = self
        dosagePickerView.delegate = self
        dosagePickerView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        if(medicineType == "Liquid"){
            currentMeasurement = "tsp"
            dosagePickerView.selectRow(1, inComponent: 0, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func doneButtonPressed(){
        if(dosageAmount.text == ""){
            let alert = UIAlertController(title: "Please enter a Dosage amount.", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            //save medicine into coredata
            let managedContext = AppDelegate().managedObjectContext
            let entity =  NSEntityDescription.entityForName("Medicine", inManagedObjectContext: managedContext)
            let medicine = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            medicine.setValue(retrievedName, forKey: "name")
            medicine.setValue(medicineType, forKey: "type")
            if(dosageAmount.text == "1" && currentMeasurement == "Pills"){
                currentMeasurement = "Pill"
            }
            let dosageValue = dosageAmount.text! + " " + currentMeasurement
            medicine.setValue(dosageValue, forKey: "dosage")
            do {
                try managedContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            //set medicine as current medicine
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(retrievedName, forKey: "CurrentMedicine")
            defaults.synchronize()

            navigationController?.popToRootViewControllerAnimated(true)
        }
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("alarmTypeVC") as! UINavigationController
        let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window!.rootViewController!.presentViewController(vc, animated: true, completion: nil)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(self.medicineType == "Pill"){
            return 2
        }
        else{
            return 3
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(self.medicineType == "Pill"){
            return pillPickerViewData[row]
        }
        else{
            return liquidPickerViewData[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(medicineType == "Pill"){
            currentMeasurement = pillPickerViewData[row]
        }
        else{
            currentMeasurement = liquidPickerViewData[row]
        }
        print(currentMeasurement)
    }
    
    internal func setType(type: String){
        if(self.medicineType != type){
            self.medicineType = type
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.utf16.count + string.utf16.count - range.length
        return newLength <= 7 // Bool
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
