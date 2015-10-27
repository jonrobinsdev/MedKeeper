//
//  PatientProfile+CoreDataProperties.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 10/27/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension PatientProfile {

    @NSManaged var alarms: NSData?
    @NSManaged var image: NSData?
    @NSManaged var name: String?

}
