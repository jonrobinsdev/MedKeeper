//
//  AddReminderScrollViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/4/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class AddReminderScrollViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var scrollViewTitle: UILabel!
    @IBOutlet private var backButton: UIButton!
    @IBOutlet private var nextButton: UIButton!
    let vc1 = AddReminderViewController1(nibName: "AddReminderView1", bundle: nil)
    let vc2 = AddReminderViewController2(nibName: "AddReminderView2", bundle: nil)
    let vc3 = AddReminderViewController3(nibName: "AddReminderView3", bundle: nil)
    let vc4 = AddReminderViewController4(nibName: "AddReminderView4", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        loadViewControllersIntoScrollView()
        checkScrollViewOffset()
    }
    
    override func viewDidLayoutSubviews() {
        self.vc1.nameField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadViewControllersIntoScrollView(){
        //First Controller
        vc1.view.frame = self.scrollView.bounds
        
        self.addChildViewController(vc1)
        self.scrollView.addSubview(vc1.view)
        self.vc1.didMoveToParentViewController(self)
        self.vc1.nameField.delegate = self
    
        //Second Controller
        var frame1 = self.scrollView.bounds
        frame1.origin.x = self.view.frame.size.width
        vc2.view.frame = frame1
        
        self.addChildViewController(vc2)
        self.scrollView.addSubview(vc2.view)
        vc2.didMoveToParentViewController(self)
        
        //Third Controller
        var frame2 = self.scrollView.bounds
        frame2.origin.x = self.view.frame.size.width*2
        vc3.view.frame = frame2
        
        self.addChildViewController(vc3)
        self.scrollView.addSubview(vc3.view)
        vc3.didMoveToParentViewController(self)
        
        //Fourth Controller
        var frame3 = self.scrollView.bounds
        frame3.origin.x = self.view.frame.size.width*3
        vc4.view.frame = frame3
        
        self.addChildViewController(vc4);
        self.scrollView.addSubview(vc4.view)
        vc4.didMoveToParentViewController(self)
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*4, self.view.frame.size.height - 250)
    }
    
    @IBAction func next(sender: AnyObject) {
        if(self.vc1.nameField.isFirstResponder()){
            self.vc1.nameField.resignFirstResponder()
            self.scrollView.scrollEnabled = true
        }
        
        let x = self.scrollView.contentOffset.x
        switch(x){
        case 0:
            self.scrollView.contentOffset = CGPoint(x: self.view.frame.size.width, y: 0)
            break
        case self.view.frame.size.width:
            self.scrollView.contentOffset = CGPoint(x: self.view.frame.size.width*2, y: 0)
            break
        case self.view.frame.size.width*2:
            self.scrollView.contentOffset = CGPoint(x: self.view.frame.size.width*3, y: 0)
            break
        case self.view.frame.size.width*3:
            break
        default:
            break
        }
        checkScrollViewOffset()
    }
    
    @IBAction func back(sender: AnyObject) {
        let x = self.scrollView.contentOffset.x
        switch(x){
        case 0:
            break
        case self.view.frame.size.width:
            self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
            break
        case self.view.frame.size.width*2:
            self.scrollView.contentOffset = CGPoint(x: self.view.frame.size.width, y: 0)
            break
        case self.view.frame.size.width*3:
            self.scrollView.contentOffset = CGPoint(x: self.view.frame.size.width*2, y: 0)
            break
        default:
            break
        }
        checkScrollViewOffset();
        
    }
    
    func checkScrollViewOffset(){
        if(self.scrollView.contentOffset.x == 0){
            self.scrollViewTitle.text = "Set The Name"
            self.nextButton.setTitle("Next", forState: .Normal)
            self.backButton.hidden = true
        }
        else{
            self.backButton.hidden = false
        }
        
        if(self.scrollView.contentOffset.x == self.view.frame.size.width){
            self.scrollViewTitle.text = "Assign The Type"
            self.nextButton.setTitle("Next", forState: .Normal)
        }
        else if(self.scrollView.contentOffset.x == self.view.frame.size.width*2){
            self.scrollViewTitle.text = "Give The Dosage"
            self.nextButton.setTitle("Next", forState: .Normal)
            let medicineType = self.vc2.getMedicineType()
            self.vc3.setType(medicineType);
        }
        else if(self.scrollView.contentOffset.x == self.view.frame.size.width*3){
            self.nextButton.setTitle("Save", forState: .Normal)
        }
        else{
            //self.nextButton.setTitle("Next", forState: .Normal)
        }
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField == self.vc1.nameField){
            self.scrollView.scrollEnabled = false
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField == self.vc1.nameField){
            self.vc1.nameField.resignFirstResponder();
            self.scrollView.scrollEnabled = true;
        }
        return true
    }
    
}