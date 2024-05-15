//
//  CoreDataCircuit+CoreDataProperties.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/15.
//
//

import Foundation
import CoreData


extension CoreDataCircuit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataCircuit> {
        return NSFetchRequest<CoreDataCircuit>(entityName: "CoreDataCircuit")
    }

    @NSManaged public var circuitName: String?
    @NSManaged public var circuitID: String?
    @NSManaged public var url: String?
    @NSManaged public var location: CoreDataLocation?

}

extension CoreDataCircuit : Identifiable {

}
