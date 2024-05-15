//
//  CoreDataRaceSessionDetail+CoreDataProperties.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/14.
//
//

import Foundation
import CoreData


extension CoreDataRaceSessionDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataRaceSessionDetail> {
        return NSFetchRequest<CoreDataRaceSessionDetail>(entityName: "CoreDataRaceSessionDetail")
    }

    @NSManaged public var date: String?
    @NSManaged public var time: String?
    @NSManaged public var type: String?

}

extension CoreDataRaceSessionDetail : Identifiable {

}
