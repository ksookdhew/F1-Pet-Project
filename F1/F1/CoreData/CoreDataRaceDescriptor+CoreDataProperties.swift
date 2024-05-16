//
//  CoreDataRaceDescriptor+CoreDataProperties.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/14.
//
//

import Foundation
import CoreData

extension CoreDataRaceDescriptor: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataRaceDescriptor> {
        return NSFetchRequest<CoreDataRaceDescriptor>(entityName: "CoreDataRaceDescriptor")
    }
}
