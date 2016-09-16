//
//  Location+CoreDataProperties.swift
//  Hackathon02
//
//  Created by Charlotte Abrams on 9/16/16.
//  Copyright © 2016 Evan Callia. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData
class Location: NSManagedObject{
    
}
extension Location {

    @NSManaged var name: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var notes: NSOrderedSet?

}
