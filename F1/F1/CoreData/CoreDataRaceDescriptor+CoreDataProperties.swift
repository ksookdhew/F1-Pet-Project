//
//  CoreDataRaceDescriptor+CoreDataProperties.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/14.
//
//

import Foundation
import CoreData


extension CoreDataRaceDescriptor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataRaceDescriptor> {
        return NSFetchRequest<CoreDataRaceDescriptor>(entityName: "CoreDataRaceDescriptor")
    }

    @NSManaged public var series: String?
    @NSManaged public var url: String?
    @NSManaged public var limit: String?
    @NSManaged public var offset: String?
    @NSManaged public var total: String?
    @NSManaged public var raceTable: CoreDataRaceTable?

}

extension CoreDataRaceDescriptor : Identifiable {

}
