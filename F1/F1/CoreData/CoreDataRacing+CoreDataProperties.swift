//
//  CoreDataRacing+CoreDataProperties.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/14.
//
//

import Foundation
import CoreData

extension CoreDataRacing: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataRacing> {
        return NSFetchRequest<CoreDataRacing>(entityName: "CoreDataRacing")
    }
}
