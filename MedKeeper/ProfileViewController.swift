//
//  FirstViewController.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/4/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var profilesTableView: UITableView!
    var profileArray: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = NSUserDefaults.standardUserDefaults()
        profileArray = defaults.objectForKey("ProfileArray") as! NSMutableArray
        
        self.profilesTableView.delegate = self
        self.profilesTableView.dataSource = self
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
        return 75;
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var cell: ProfileCustomCell! = tableView.dequeueReusableCellWithIdentifier("profileCustomCell") as? ProfileCustomCell
            if(cell == nil) {
                tableView.registerNib(UINib(nibName: "ProfileCustomCell", bundle: nil), forCellReuseIdentifier: "profileCustomCell")
                cell = tableView.dequeueReusableCellWithIdentifier("profileCustomCell") as? ProfileCustomCell
            }
            cell.nameLabel.text = profileArray[indexPath.row] as? String
            cell.textLabel?.backgroundColor = UIColor.clearColor()
            return cell
    }



}

