//
//  CoreDataCircuit+CoreDataProperties.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/15.
//
//

import Foundation
import CoreData

extension CoreDataCircuit: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataCircuit> {
        return NSFetchRequest<CoreDataCircuit>(entityName: "CoreDataCircuit")
    }
}
