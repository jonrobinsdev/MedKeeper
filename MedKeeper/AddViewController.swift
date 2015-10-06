//
//  AddViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/4/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true);
        
        let vc0 = AddReminderViewController1(nibName: "AddReminderView1", bundle: nil);
        
        self.addChildViewController(vc0);
        self.scrollView.addSubview(vc0.view);
        vc0.didMoveToParentViewController(self);
        
        let vc1 = AddReminderViewController1(nibName: "AddReminderView1", bundle: nil);
        
        var frame1 = vc1.view.frame;
        frame1.origin.x = self.view.frame.size.width;
        vc1.view.frame = frame1;
        
        self.addChildViewController(vc1);
        self.scrollView.addSubview(vc1.view);
        vc1.didMoveToParentViewController(self);
        
        let vc2 = AddReminderViewController1(nibName: "AddReminderView1", bundle: nil);
        
        var frame2 = vc2.view.frame;
        frame2.origin.x = self.view.frame.size.width*2;
        vc2.view.frame = frame2;
        
        self.addChildViewController(vc2);
        self.scrollView.addSubview(vc2.view);
        vc2.didMoveToParentViewController(self);
        
        let vc3 = AddReminderViewController1(nibName: "AddReminderView1", bundle: nil);
        
        var frame3 = vc3.view.frame;
        frame3.origin.x = self.view.frame.size.width*3;
        vc3.view.frame = frame3;
        
        self.addChildViewController(vc3);
        self.scrollView.addSubview(vc3.view);
        vc3.didMoveToParentViewController(self);
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*4, self.view.frame.size.height - 66);
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}