//
//  AlarmCustomCell.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/21/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class AlarmCustomCell: UITableViewCell {
    
    var delegate : AlarmCustomCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.textLabel!.font = UIFont.systemFontOfSize(22.0)
        self.textLabel!.backgroundColor = UIColor.clearColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteButtonPressed(cell: AnyObject) {
        delegate?.deleteButtonPressed(self)
    }
}
