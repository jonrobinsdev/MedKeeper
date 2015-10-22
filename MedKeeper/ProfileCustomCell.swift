//
//  ProfileCustomCell.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/22/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class ProfileCustomCell: UITableViewCell {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
