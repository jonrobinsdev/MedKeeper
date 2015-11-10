//
//  AlarmCustomCell.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/21/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

protocol NormalAlarmCustomCellDelegate {
    func deleteButtonPressed(cell: NormalAlarmCustomCell)
}

class NormalAlarmCustomCell: UITableViewCell {
    
    var delegate : NormalAlarmCustomCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textLabel?.font = UIFont(name: "Avenir-Light", size: 24)
        textLabel!.backgroundColor = UIColor.clearColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteButtonPressed(cell: AnyObject) {
        delegate?.deleteButtonPressed(self)
    }
}
