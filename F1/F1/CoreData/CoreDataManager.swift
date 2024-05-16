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

    // MARK: Variables
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

    // MARK: Functions
    func saveRaceInfo(_ racing: Racing) {
        deleteOldData()

        let raceDescriptor = racing.race
        let raceTable = raceDescriptor.raceTable

        for raceInfo in raceTable.races {
            saveRace(raceInfo)
        }
        saveData()

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

    // MARK: Helper Functions
    private func deleteOldData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CoreDataRaceInfo.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete old data: \(error)")
        }
    }

    private func saveData() {
        do {
            try context.save()
        } catch {
            print("Failed to save data: \(error)")
        }
    }

    private func saveRace(_ raceInfo: RaceInfo) {
        let raceEntity = CoreDataRaceInfo(context: context)
        raceEntity.raceName = raceInfo.raceName
        raceEntity.date = raceInfo.date
        raceEntity.time = raceInfo.time
        raceEntity.season = raceInfo.season
        raceEntity.url = raceInfo.url
        raceEntity.round = raceInfo.round

        let circuitEntity = saveCircuit(raceInfo.circuit)
        raceEntity.circuit = circuitEntity

        let firstPractice = saveSession(raceInfo.firstPractice)
        raceEntity.firstPractice = firstPractice

        let secondPractice = saveSession(raceInfo.secondPractice)
        raceEntity.secondPractice = secondPractice

        if let thirdPractice = raceInfo.thirdPractice {
            let thirdPracticeSession = saveSession(thirdPractice)
            raceEntity.thirdPractice = thirdPracticeSession
        }

        let qualifying = saveSession(raceInfo.qualifying)
        raceEntity.qualifying = qualifying

        if let sprint = raceInfo.sprint {
            let sprintSession = saveSession(sprint)
            raceEntity.sprint = sprintSession
        }
    }

    private func saveCircuit(_ circuit: Circuit) -> CoreDataCircuit {
        let circuitEntity = CoreDataCircuit(context: context)
        circuitEntity.circuitName = circuit.circuitName
        circuitEntity.circuitID = circuit.circuitID
        circuitEntity.url = circuit.url

        let locationEntity = saveLocation(circuit.location)
        circuitEntity.location = locationEntity

        return circuitEntity
    }

    private func saveLocation(_ location: Location) -> CoreDataLocation {
        let locationEntity = CoreDataLocation(context: context)
        locationEntity.country = location.country
        locationEntity.locality = location.locality
        locationEntity.latitude = location.latitude
        locationEntity.longitude = location.longitude

        return locationEntity
    }

    private func saveSession(_ session: RaceSession) -> CoreDataRaceSession {
        let sessionEntity = CoreDataRaceSession(context: context)
        sessionEntity.date = session.date
        sessionEntity.time = session.time

        return sessionEntity
    }
}
