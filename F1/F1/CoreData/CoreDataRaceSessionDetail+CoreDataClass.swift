//
//  CoreDataRaceSessionDetail+CoreDataClass.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/14.
//
//

import Foundation
import CoreData

public class CoreDataRaceSessionDetail: NSManagedObject {

    @NSManaged public var date: String?
    @NSManaged public var time: String?
    @NSManaged public var type: String?

}
