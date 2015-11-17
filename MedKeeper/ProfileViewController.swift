//
//  FirstViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/4/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet var profilesTableView: UITableView!
    var profileArray: NSArray = [NSManagedObject]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action:"addProfileButtonPressed:")
        navigationItem.rightBarButtonItem = addButton
        
        self.profilesTableView.delegate = self
        self.profilesTableView.dataSource = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest = NSFetchRequest(entityName: "PatientProfile")
        do {
            try managedObjectContext.executeFetchRequest(fetchRequest)
            profileArray = try managedObjectContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        profilesTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var cell: ProfileCustomCell! = tableView.dequeueReusableCellWithIdentifier("profileCustomCell") as? ProfileCustomCell
            if(cell == nil) {
                tableView.registerNib(UINib(nibName: "ProfileCustomCell", bundle: nil), forCellReuseIdentifier: "profileCustomCell")
                cell = tableView.dequeueReusableCellWithIdentifier("profileCustomCell") as? ProfileCustomCell
            }
            let patientProfile:PatientProfile = profileArray[indexPath.row] as! PatientProfile
            cell.nameLabel.text = patientProfile.name
            cell.textLabel?.backgroundColor = UIColor.clearColor()
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let patientProfile:PatientProfile = profileArray[indexPath.row] as! PatientProfile
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(patientProfile.valueForKey("name"), forKey: "CurrentUser")
        
        let fetchRequest = NSFetchRequest(entityName: "PatientProfile")
        do {
            let results = try managedObjectContext.executeFetchRequest(fetchRequest)
            profileArray = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        profilesTableView.reloadData()

        //self.performSegueWithIdentifier("profileCellToDetailedProfileVC", sender: self)
    }

    func addProfileButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("addNewProfileSegue", sender: self)
    }

}

