//
//  AddReminderViewController5b.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/5/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class AddReminderViewController5b: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    @IBOutlet var fromRangeField: UITextField!
    @IBOutlet var toRangeField: UITextField!
    @IBOutlet private  var intervalPickerView: UIPickerView!
    private var pickerViewData = ["1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5", "5.5", "6", "6.5", "7", "7.5", "8", "8.5", "9", "9.5", "10", "10.5", "11", "11.5", "12", "12.5", "13", "13.5", "14", "14.5", "15", "15.5", "16", "16.5", "17", "17.5", "18", "18.5", "19", "19.5", "20", "20.5", "21", "21.5", "22", "22.5", "23", "23.5", "24"]
    let dateFormatter = NSDateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dateFormatter
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        //pickerView
        self.intervalPickerView.delegate = self
        self.intervalPickerView.dataSource = self
        self.intervalPickerView.selectRow(4, inComponent: 0, animated: true)
        
        //textfield
        self.fromRangeField.delegate = self
        self.toRangeField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {    //delegate method
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        if(textField == self.fromRangeField){
            datePickerView.addTarget(self, action: Selector("fromDatePickerValueChanged:"), forControlEvents:UIControlEvents.ValueChanged)
        }
        else{
            datePickerView.addTarget(self, action: Selector("toDatePickerValueChanged:"), forControlEvents:UIControlEvents.ValueChanged)
        }
        textField.inputView = datePickerView
        textField.text = dateFormatter.stringFromDate(datePickerView.date)
    }
    
    func fromDatePickerValueChanged(sender:UIDatePicker) {
        self.fromRangeField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    func toDatePickerValueChanged(sender:UIDatePicker) {
        self.toRangeField.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 47
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewData[row]
    }

    func dismissKeyboard(){
        view.endEditing(true)
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
