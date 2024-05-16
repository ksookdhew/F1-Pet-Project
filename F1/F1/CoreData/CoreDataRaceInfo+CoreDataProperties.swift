//
//  CoreDataRaceInfo+CoreDataProperties.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/14.
//
//

import Foundation
import CoreData

extension CoreDataRaceInfo: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataRaceInfo> {
        return NSFetchRequest<CoreDataRaceInfo>(entityName: "CoreDataRaceInfo")
    }
}
