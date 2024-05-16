//
//  CoreDataRaceInfo+CoreDataClass.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/14.
//
//

import Foundation
import CoreData

public class CoreDataRaceInfo: NSManagedObject {
    @NSManaged public var season: String?
    @NSManaged public var round: String?
    @NSManaged public var url: String?
    @NSManaged public var raceName: String?
    @NSManaged public var date: String?
    @NSManaged public var time: String?
    @NSManaged public var circuit: CoreDataCircuit?
    @NSManaged public var firstPractice: CoreDataRaceSession?
    @NSManaged public var secondPractice: CoreDataRaceSession?
    @NSManaged public var thirdPractice: CoreDataRaceSession?
    @NSManaged public var qualifying: CoreDataRaceSession?
    @NSManaged public var sprint: CoreDataRaceSession?
}
