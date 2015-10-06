//
//  AddReminderViewController2.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/5/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class AddReminderViewController2: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    var pillPickerViewData = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"], ["pills", "mg"]];
    var syrupPickerViewData = [["10", "20", "30", "40", "50", "60", "70", "80", "90", "100"], ["tsp", "Tbsp", "mL"]];
    
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
            return syrupPickerViewData.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(segmentedControl.selectedSegmentIndex == 0){
            return pillPickerViewData[component].count
        }
        else{
            return syrupPickerViewData[component].count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(segmentedControl.selectedSegmentIndex == 0){
            return pillPickerViewData[component][row]
        }
        else{
            return syrupPickerViewData[component][row]
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
