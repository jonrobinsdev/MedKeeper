//
//  AddReminderScrollViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/4/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class AddReminderScrollViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var scrollViewTitle: UILabel!
    @IBOutlet private var backButton: UIButton!
    @IBOutlet private var nextButton: UIButton!
    let vc1 = AddReminderViewController1(nibName: "AddReminderView1", bundle: nil)
    let vc2 = AddReminderViewController2(nibName: "AddReminderView2", bundle: nil)
    let vc3 = AddReminderViewController3(nibName: "AddReminderView3", bundle: nil)
    let vc4 = AddReminderViewController4(nibName: "AddReminderView4", bundle: nil)
    var vc5 : UIViewController = AddReminderViewController5a(nibName: "AddReminderView5a", bundle: nil)
    let vc6 = AddReminderViewController6(nibName: "AddReminderView6", bundle: nil)
    var directionIsForward : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        loadViewControllersIntoScrollView()
        self.vc1.nameField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
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
        self.vc3.dosageTextField.delegate = self
        self.vc3.dosageTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        
        //Fourth Controller
        var frame3 = self.scrollView.bounds
        frame3.origin.x = self.view.frame.size.width*3
        vc4.view.frame = frame3
        
        self.addChildViewController(vc4)
        self.scrollView.addSubview(vc4.view)
        vc4.didMoveToParentViewController(self)
        
        //Fifth Controller
        var frame4 = self.scrollView.bounds
        frame4.origin.x = self.view.frame.size.width*4
        vc5.view.frame = frame4
    
        self.addChildViewController(vc5)
        self.scrollView.addSubview(vc5.view)
        vc5.didMoveToParentViewController(self)
        
        //Sixth Controller
        var frame5 = self.scrollView.bounds
        frame5.origin.x = self.view.frame.size.width*5
        vc6.view.frame = frame5
        
        self.addChildViewController(vc6)
        self.scrollView.addSubview(vc6.view)
        vc6.didMoveToParentViewController(self)

        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*6, self.view.frame.size.height - 250)
    }
    
    @IBAction func next(sender: AnyObject) {
        self.next()
    }
    
    @IBAction func back(sender: AnyObject) {
        self.back()
    }
    
    
    func next(){
        self.directionIsForward = true
        let x = self.scrollView.contentOffset.x
        switch(x){
        case 0:
            self.scrollView.setContentOffset(CGPointMake(self.view.frame.size.width, 0), animated: true)
            break
        case self.view.frame.size.width:
            self.scrollView.setContentOffset(CGPointMake(self.view.frame.size.width*2, 0), animated: true)
            break
        case self.view.frame.size.width*2:
            self.scrollView.setContentOffset(CGPointMake(self.view.frame.size.width*3, 0), animated: true)
            break
        case self.view.frame.size.width*3:
            self.scrollView.setContentOffset(CGPointMake(self.view.frame.size.width*4, 0), animated: true)
            break
        case self.view.frame.size.width*4:
            self.scrollView.setContentOffset(CGPointMake(self.view.frame.size.width*5, 0), animated: true)
            break
        case self.view.frame.size.width*4:
            break
        default:
            break
        }
    }
    
    func back(){
        self.directionIsForward = false
        let x = self.scrollView.contentOffset.x
        switch(x){
        case 0:
            break
        case self.view.frame.size.width:
            self.scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
            break
        case self.view.frame.size.width*2:
            self.scrollView.setContentOffset(CGPointMake(self.view.frame.size.width, 0), animated: true)
            break
        case self.view.frame.size.width*3:
            self.scrollView.setContentOffset(CGPointMake(self.view.frame.size.width*2, 0), animated: true)
            break
        case self.view.frame.size.width*4:
            self.scrollView.setContentOffset(CGPointMake(self.view.frame.size.width*3, 0), animated: true)
            break
        case self.view.frame.size.width*5:
            self.scrollView.setContentOffset(CGPointMake(self.view.frame.size.width*4, 0), animated: true)
            break
        default:
            break
        }
    }
    
    func scrollViewDidScroll(_scrollView: UIScrollView){
        self.view.endEditing(true)
        if(self.scrollView.contentOffset.x == 0){
            self.nextButton.setTitle("Next", forState: .Normal)
            self.backButton.hidden = true
            if(directionIsForward){
                self.vc1.nameField.becomeFirstResponder()
            }
        }
        else{
            self.backButton.hidden = false
        }
        
        if(self.scrollView.contentOffset.x == self.view.frame.size.width){
            self.nextButton.setTitle("Next", forState: .Normal)
        }
        else if(self.scrollView.contentOffset.x == self.view.frame.size.width*2){
            self.nextButton.setTitle("Next", forState: .Normal)
            let medicineType = self.vc2.getMedicineType()
            self.vc3.setType(medicineType)
            if(directionIsForward){
                self.vc3.dosageTextField.becomeFirstResponder()
            }
        }
        else if(self.scrollView.contentOffset.x == self.view.frame.size.width*3){
            self.nextButton.setTitle("Next", forState: .Normal)
        }
        else if(self.scrollView.contentOffset.x == self.view.frame.size.width*4){
            self.nextButton.setTitle("Next", forState: .Normal)
            let alarmType = self.vc4.getAlarmType()
            if(alarmType == "Normal"){
                vc5 = AddReminderViewController5a(nibName: "AddReminderView5a", bundle: nil)
            }
            else{
                vc5 = AddReminderViewController5b(nibName: "AddReminderView5b", bundle: nil)
                
            }
            vc5.view.removeFromSuperview()
            var frame4 = self.scrollView.bounds
            frame4.origin.x = self.view.frame.size.width*4
            vc5.view.frame = frame4
            self.scrollView.addSubview(vc5.view)
        }
        else if(self.scrollView.contentOffset.x == self.view.frame.size.width*5){
            self.nextButton.setTitle("Save", forState: .Normal)
        }
        else{
            
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField == self.vc1.nameField){
            self.scrollView.scrollEnabled = false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField == self.vc1.nameField){
            self.scrollView.scrollEnabled = true
            if(directionIsForward){
                self.next()
            }
        }
        else if(textField == self.vc3.dosageTextField){
            if(directionIsForward){
                self.next()
            }
        }
        return true
    }
    
}