//
//  AlarmsCustomCell.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 11/5/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class AlarmsCustomCell: UITableViewCell {
    @IBOutlet var alarmTime: UILabel!
    @IBOutlet var weekdays: UILabel!
    @IBOutlet var alarmSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        alarmSwitch.transform = CGAffineTransformMakeScale(0.80, 0.80)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
