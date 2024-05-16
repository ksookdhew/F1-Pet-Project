//
//  CoreDataCircuit+CoreDataClass.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/15.
//
//

import Foundation
import CoreData

public class CoreDataCircuit: NSManagedObject {

    @NSManaged public var circuitName: String?
    @NSManaged public var circuitID: String?
    @NSManaged public var url: String?
    @NSManaged public var location: CoreDataLocation?
}
