//
//  CoreDataLocation+CoreDataProperties.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/15.
//
//

import Foundation
import CoreData

extension CoreDataLocation: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataLocation> {
        return NSFetchRequest<CoreDataLocation>(entityName: "CoreDataLocation")
    }
}
