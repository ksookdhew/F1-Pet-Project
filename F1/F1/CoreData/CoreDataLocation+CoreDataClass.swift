//
//  CoreDataLocation+CoreDataClass.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/15.
//
//

import Foundation
import CoreData

public class CoreDataLocation: NSManagedObject {

    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var locality: String?
    @NSManaged public var country: String?
}
