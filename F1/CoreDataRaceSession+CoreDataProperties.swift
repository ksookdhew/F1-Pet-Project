//
//  CoreDataRaceSession+CoreDataProperties.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/14.
//
//

import Foundation
import CoreData


extension CoreDataRaceSession {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataRaceSession> {
        return NSFetchRequest<CoreDataRaceSession>(entityName: "CoreDataRaceSession")
    }

    @NSManaged public var date: String?
    @NSManaged public var time: String?

}

extension CoreDataRaceSession : Identifiable {

}
