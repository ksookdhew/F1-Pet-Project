//
//  CoreDataRaceTable+CoreDataProperties.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/14.
//
//

import Foundation
import CoreData

extension CoreDataRaceTable: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataRaceTable> {
        return NSFetchRequest<CoreDataRaceTable>(entityName: "CoreDataRaceTable")
    }
}

// MARK: accessors for races
extension CoreDataRaceTable {

    @objc(addRacesObject:)
    @NSManaged public func addToRaces(_ value: CoreDataRaceInfo)

    @objc(removeRacesObject:)
    @NSManaged public func removeFromRaces(_ value: CoreDataRaceInfo)

    @objc(addRaces:)
    @NSManaged public func addToRaces(_ values: NSSet)

    @objc(removeRaces:)
    @NSManaged public func removeFromRaces(_ values: NSSet)

}
