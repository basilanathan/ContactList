//
//  Contact+CoreDataProperties.swift
//  Contact_list
//
//  Created by Basila Nathan on 3/24/17.
//  Copyright © 2017 Basila Nathan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contact {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var number: String?

}
