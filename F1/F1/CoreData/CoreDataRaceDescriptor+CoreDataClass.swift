//
//  CoreDataRaceDescriptor+CoreDataClass.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/14.
//
//

import Foundation
import CoreData

public class CoreDataRaceDescriptor: NSManagedObject {

    @NSManaged public var series: String?
    @NSManaged public var url: String?
    @NSManaged public var limit: String?
    @NSManaged public var offset: String?
    @NSManaged public var total: String?
    @NSManaged public var raceTable: CoreDataRaceTable?
}
