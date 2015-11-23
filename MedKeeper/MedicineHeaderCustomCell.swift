//
//  MedicineHeaderCustomCell.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 11/5/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import UIKit

protocol MedicineHeaderCustomCellDelegate {
    func didSelectUserHeaderTableViewCell(Selected: Bool, UserHeader: MedicineHeaderCustomCell)
}

class MedicineHeaderCustomCell: UITableViewCell {

    var delegate : MedicineHeaderCustomCellDelegate?
    var section:Int?
    
    @IBOutlet var medicineImage: UIImageView!
    @IBOutlet var medicineNameLabel: UILabel!
    var medicineType = ""
    @IBOutlet var dosageLabel: UILabel!
    @IBOutlet var arrowLabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        //medicineImage.layer.cornerRadius = medicineImage.frame.size.width/2
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func selectedHeader(sender: AnyObject) {
        delegate?.didSelectUserHeaderTableViewCell(true, UserHeader: self)
        
    }

    
}
