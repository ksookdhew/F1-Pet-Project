//
//  CoreDataLocation+CoreDataProperties.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/15.
//
//

import Foundation
import CoreData


extension CoreDataLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataLocation> {
        return NSFetchRequest<CoreDataLocation>(entityName: "CoreDataLocation")
    }

    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var locality: String?
    @NSManaged public var country: String?

}

extension CoreDataLocation : Identifiable {

}
