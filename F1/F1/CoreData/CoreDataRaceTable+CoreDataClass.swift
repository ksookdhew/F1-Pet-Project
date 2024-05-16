//
//  CoreDataRaceTable+CoreDataClass.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/14.
//
//

import Foundation
import CoreData

public class CoreDataRaceTable: NSManagedObject {

    @NSManaged public var season: String?
    @NSManaged public var races: NSSet?
}
