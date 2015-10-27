//
//  NormalAlarm.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/27/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//

import Foundation

class NormalAlarm{
    
    var medicationName: String!
    var medicationType: String!
    var medicationDosage: String!
    var alarms: NSArray!
    var weekdays: NSArray!
    
    init(){
        self.medicationName = nil
        self.medicationType = nil
        self.alarms = nil
        self.weekdays = nil
    }
}
