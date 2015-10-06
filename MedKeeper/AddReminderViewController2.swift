//
//  AddReminderViewController2.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/5/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class AddReminderViewController2: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet var amountPickerView: UIPickerView!

    @IBOutlet var typePickerView: UIPickerView!
    var amountPickerViewData = ["lol", "hi", "yup"];
    var typePickerViewData = ["herp", "derp", "flerp"];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        amountPickerView.delegate = self;
        amountPickerView.dataSource = self;
        typePickerView.delegate = self;
        typePickerView.dataSource = self;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == amountPickerView){
            return 3
        }
        else{
            return 3
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == amountPickerView){
            return amountPickerViewData[row]
        }
        else{
            return typePickerViewData[row]
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
