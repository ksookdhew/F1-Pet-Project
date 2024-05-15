//
//  CoreDataManager.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/15.
//
import CoreData
import Foundation
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    let appDelegate: AppDelegate
    let context: NSManagedObjectContext

    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to access AppDelegate")
        }

        self.appDelegate = appDelegate
        context = appDelegate.persistentContainer.viewContext
    }

    func saveRaceInfo(_ racing: Racing) {

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CoreDataRaceInfo.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete old data: \(error)")
        }

        let raceDescriptor = racing.race
        let raceTable = raceDescriptor.raceTable

        for raceInfo in raceTable.races {
            let raceEntity = CoreDataRaceInfo(context: context)
            raceEntity.raceName = raceInfo.raceName
            raceEntity.date = raceInfo.date
            raceEntity.time = raceInfo.time
            raceEntity.season = raceInfo.season
            raceEntity.url = raceInfo.url
            raceEntity.round = raceInfo.round

            let circuitEntity = CoreDataCircuit(context: context)
            circuitEntity.circuitName = raceInfo.circuit.circuitName
            circuitEntity.circuitID = raceInfo.circuit.circuitID
            circuitEntity.url = raceInfo.circuit.url

            let locationEntity = CoreDataLocation(context: context)
            locationEntity.country = raceInfo.circuit.location.country
            locationEntity.locality = raceInfo.circuit.location.locality
            locationEntity.latitude = raceInfo.circuit.location.latitude
            locationEntity.longitude = raceInfo.circuit.location.longitude

            circuitEntity.location = locationEntity
            raceEntity.circuit = circuitEntity

            let firstPractice = CoreDataRaceSession(context: context)
            firstPractice.date = raceInfo.firstPractice.date
            firstPractice.time = raceInfo.firstPractice.time
            raceEntity.firstPractice = firstPractice

            let secondPractice = CoreDataRaceSession(context: context)
            secondPractice.date = raceInfo.secondPractice.date
            secondPractice.time = raceInfo.secondPractice.time
            raceEntity.secondPractice = secondPractice

            if let thirdPractice = raceInfo.thirdPractice {
                let thirdPracticeSession = CoreDataRaceSession(context: context)
                thirdPracticeSession.date = thirdPractice.date
                thirdPracticeSession.time = thirdPractice.time
                raceEntity.thirdPractice = thirdPracticeSession
            }

            let qualifying = CoreDataRaceSession(context: context)
            qualifying.date = raceInfo.qualifying.date
            qualifying.time = raceInfo.qualifying.time
            raceEntity.qualifying = qualifying

            if let sprint = raceInfo.sprint {
                let sprintSession = CoreDataRaceSession(context: context)
                sprintSession.date = sprint.date
                sprintSession.time = sprint.time
                raceEntity.sprint = sprintSession
            }

        }

        do {
            try context.save()
        } catch {
            print("Failed to save data: \(error)")
        }
    }

    func fetchRaces() -> [RaceInfo]? {
        let fetchRequest: NSFetchRequest<CoreDataRaceInfo> = CoreDataRaceInfo.fetchRequest()

        do {
            let coreDataRaces = try context.fetch(fetchRequest)
            return coreDataRaces.map { RaceInfo(from: $0) }
        } catch {
            print("Failed to fetch races: \(error)")
            return nil
        }
    }
}
