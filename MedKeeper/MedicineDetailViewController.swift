//
//  MedicineDetailViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 11/6/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class MedicineDetailViewController: UIViewController {

    @IBOutlet var dosageAmountLabel: UILabel!
    @IBOutlet var medicineTypeLabel: UILabel!
    var medicineName : String = ""
    var medicineType : String = ""
    var dosageAmount : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        navigationItem.title = medicineName
        medicineTypeLabel.text = medicineType
        dosageAmountLabel.text = dosageAmount
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
