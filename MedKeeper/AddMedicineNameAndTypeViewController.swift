//
//  AddMedicineNameAndTypeViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 11/2/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class AddMedicineNameAndTypeViewController: UIViewController {
    
    @IBOutlet var medicineNameTextField: UITextField!
    @IBOutlet var typeSegmentController: UISegmentedControl!
    var currentSegmentControlIndex = 0;
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Add a Medication"
        
        let nextButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: Selector("nextButtonPressed"))
        navigationItem.rightBarButtonItem = nextButton
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextButtonPressed(){
        performSegueWithIdentifier("segueToDosage", sender: self)
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
