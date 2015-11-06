//
//  MedicineHeaderCustomCell.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 11/5/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

class MedicineHeaderCustomCell: UITableViewCell {

    @IBOutlet var medicineImage: UIImageView!
    @IBOutlet var medicineNameLabel: UILabel!
    @IBOutlet var dosageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        //medicineImage.layer.cornerRadius = medicineImage.frame.size.width/2
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
