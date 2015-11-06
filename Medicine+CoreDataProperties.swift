//
//  Medicine+CoreDataProperties.swift
//  MedKeeper
//
//  Created by Jonathan Robins on 11/5/15.
//  Copyright © 2015 Round Robin Apps. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Medicine {

    @NSManaged var name: String?
    @NSManaged var dosage: String?
    @NSManaged var type: String?
    @NSManaged var image: NSData?

}
