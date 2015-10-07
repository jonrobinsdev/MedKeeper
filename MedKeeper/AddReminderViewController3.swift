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
    
    var pillPickerViewData = [["1/8", "1/4", "1/2", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"], ["pills", "mg"]];
    var liquidPickerViewData = [["5", "10", "15", "20", "25", "30", "35", "40", "45", "50","55", "60", "65", "70", "75", "80", "85", "90", "95", "100"], ["tsp", "Tbsp", "mL"]];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self;
        pickerView.dataSource = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if(segmentedControl.selectedSegmentIndex == 0){
            return pillPickerViewData.count
        }
        else{
            return liquidPickerViewData.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(segmentedControl.selectedSegmentIndex == 0){
            return pillPickerViewData[component].count
        }
        else{
            return liquidPickerViewData[component].count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(segmentedControl.selectedSegmentIndex == 0){
            return pillPickerViewData[component][row]
        }
        else{
            return liquidPickerViewData[component][row]
        }
    }
    @IBAction func segmentControlChanges(sender: AnyObject) {
        self.pickerView.reloadAllComponents();
        pickerView.selectRow(0, inComponent: 0, animated: true);
        pickerView.selectRow(0, inComponent: 1, animated: true);
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
