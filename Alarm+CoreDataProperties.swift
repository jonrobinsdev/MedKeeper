//
//  Alarm+CoreDataProperties.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 11/9/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Alarm {

    @NSManaged var time: NSDate?
    @NSManaged var weekdays: String?
    @NSManaged var isOwnedByMedicine: Medicine?

}
