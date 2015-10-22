//
//  AddReminderViewController3.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/5/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit


class AddReminderViewController3: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    @IBOutlet private var pickerView: UIPickerView!
    @IBOutlet var dosageTextField: UITextField!
    private var medicineType = "Pill"
    private var pillPickerViewData = ["Pills", "mg"]
    private var liquidPickerViewData = ["Tbsp", "tsp", "mL"]
    private var maxLength = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dosageTextField.delegate = self
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.selectRow(0, inComponent: 0, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    internal func setType(type: String){
        if(self.medicineType != type){
            self.medicineType = type
            self.pickerView.reloadAllComponents()
            if(self.medicineType == "Pill"){
                self.pickerView.selectRow(0, inComponent: 0, animated: true)
            }
            else{
                self.pickerView.selectRow(1, inComponent: 0, animated: true)
            }
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
