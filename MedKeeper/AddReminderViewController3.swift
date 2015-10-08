//
//  AddReminderViewController3.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/5/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class AddReminderViewController3: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet private var pickerView: UIPickerView!
    @IBOutlet private var segmentedControl: UISegmentedControl!
    internal var medicineType = "";
    
    var pillPickerViewData1 = [["1/8", "1/4", "1/2", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"], ["pills"]];
    var pillPickerViewData2 = [["5", "10", "15", "20", "25", "30", "35", "40", "45", "50","55", "60", "65", "70", "75", "80", "85", "90", "95", "100"], ["mg"]];
    var liquidPickerViewData1 = [["1/8", "1/4", "1/2", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"], ["tsps"]];
    var liquidPickerViewData2 = [["5", "10", "15", "20", "25", "30", "35", "40", "45", "50","55", "60", "65", "70", "75", "80", "85", "90", "95", "100"], ["mL"]];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self;
        pickerView.dataSource = self;
        self.pickerView.selectRow(3, inComponent: 0, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if(self.medicineType == "pill"){
            if(segmentedControl.selectedSegmentIndex == 0){
                return pillPickerViewData1.count
            }
            else{
                return pillPickerViewData2.count
            }
        }
        else{
            if(segmentedControl.selectedSegmentIndex == 0){
                return liquidPickerViewData1.count
            }
            else{
                return liquidPickerViewData2.count
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(self.medicineType == "pill"){
            if(segmentedControl.selectedSegmentIndex == 0){
                return pillPickerViewData1[component].count
            }
            else{
                return pillPickerViewData2[component].count
            }
        }
        else{
            if(segmentedControl.selectedSegmentIndex == 0){
                return liquidPickerViewData1[component].count
            }
            else{
                return liquidPickerViewData2[component].count
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(self.medicineType == "pill"){
            if(segmentedControl.selectedSegmentIndex == 0){
                return pillPickerViewData1[component][row]
            }
            else{
                return pillPickerViewData2[component][row]
            }
        }
        else{
            if(segmentedControl.selectedSegmentIndex == 0){
                return liquidPickerViewData1[component][row]
            }
            else{
                return liquidPickerViewData2[component][row]
            }
        }
    }
    
    @IBAction func segmentControlChanges(sender: AnyObject) {
        self.pickerView.reloadAllComponents();
        self.pickerView.selectRow(3, inComponent: 0, animated: true)
    }
    
    internal func setType(type: String){
        self.medicineType = type;
        self.pickerView.reloadAllComponents();
        self.segmentedControl.selectedSegmentIndex = 0;
        self.pickerView.selectRow(3, inComponent: 0, animated: true)

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
