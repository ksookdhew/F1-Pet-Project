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

    func saveRacingResults(_ racingResults: RacingResults) {
        deleteOldResultsData()

        let resultsDescriptor = racingResults.results
        let raceTable = resultsDescriptor.raceTable

        for race in raceTable.races {
            saveRaceWithResults(race)
        }
        saveData()
    }

    func saveDriverStandings(_ driverStandingsModel: DriverStandingsModel) {
        deleteOldDriverStandingsData()

        let standingsResponse = driverStandingsModel.driverStandings
        let standingsTable = standingsResponse.standingsTable

        let standingsTableEntity = CoreDataDriverStandingsTable(context: context)
        standingsTableEntity.season = standingsTable.season

        for standingsList in standingsTable.standingsLists {
            saveDriverStandingsList(standingsList)
        }

        saveData()
    }

    func saveConstructorStandings(_ constructorStandingsModel: ConstructorStandingsModel) {
            deleteOldConstructorStandingsData()

            let standingsResponse = constructorStandingsModel.constructorStandings
            let standingsTable = standingsResponse.standingsTable

            let standingsTableEntity = CoreDataConstructorStandingsTable(context: context)
            standingsTableEntity.season = standingsTable.season

            for standingsList in standingsTable.standingsLists {
                saveConstructorStandingsList(standingsList)
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

    func fetchResults() -> [Race]? {
        let fetchRequest: NSFetchRequest<CoreDataRace> = CoreDataRace.fetchRequest()

        do {
            let coreDataResults = try context.fetch(fetchRequest)
            return coreDataResults.map { Race(from: $0) }
        } catch {
            print("Failed to fetch races: \(error)")
            return nil
        }
    }

    func fetchDriverStandings() -> DriverStandingsModel? {
        let fetchRequest: NSFetchRequest<CoreDataDriverStandingsTable> = CoreDataDriverStandingsTable.fetchRequest()

        do {
            let coreDataStandingsTables = try context.fetch(fetchRequest)
            guard let coreDataStandingsTable = coreDataStandingsTables.first else {
                return nil
            }
            return DriverStandingsModel(from: coreDataStandingsTable)
        } catch {
            print("Failed to fetch driver standings: \(error)")
            return nil
        }
    }

    func fetchConstructorStandings() -> ConstructorStandingsModel? {
        let fetchRequest: NSFetchRequest<CoreDataConstructorStandingsTable> = CoreDataConstructorStandingsTable.fetchRequest()

        do {
            let coreDataStandingsTables = try context.fetch(fetchRequest)
            guard let coreDataStandingsTable = coreDataStandingsTables.first else {
                return nil
            }
            return ConstructorStandingsModel(from: coreDataStandingsTable)
        } catch {
            print("Failed to fetch constructor standings: \(error)")
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

    private func saveRaceWithResults(_ race: Race) {
        let raceEntity = CoreDataRace(context: context)
        raceEntity.raceName = race.raceName
        raceEntity.date = race.date
        raceEntity.time = race.time
        raceEntity.season = race.season
        raceEntity.url = race.url
        raceEntity.round = race.round

        let circuitEntity = saveCircuit(race.circuit)
        raceEntity.circuit = circuitEntity

        for result in race.results {
            raceEntity.addToResults(saveRaceResult(result, to: raceEntity))
        }
    }

    private func deleteOldResultsData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CoreDataRaceResult.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete old results data: \(error)")
        }
    }
    private func saveRaceResult(_ result: RaceResult, to raceEntity: CoreDataRace) -> CoreDataRaceResult {
        let resultEntity = CoreDataRaceResult(context: context)
        resultEntity.number = result.number
        resultEntity.position = result.position
        resultEntity.positionText = result.positionText
        resultEntity.points = result.points
        resultEntity.grid = result.grid
        resultEntity.laps = result.laps
        resultEntity.status = result.status

        if let time = result.time {
            let timeEntity = CoreDataResultTime(context: context)
            timeEntity.millis = time.millis
            timeEntity.time = time.time
            resultEntity.time = timeEntity
        }

        if let fastestLap = result.fastestLap {
            let fastestLapEntity = CoreDataFastestLap(context: context)
            fastestLapEntity.rank = fastestLap.rank
            fastestLapEntity.lap = fastestLap.lap
            fastestLapEntity.time = saveFastestLapTime(fastestLap.time)
            fastestLapEntity.averageSpeed = saveAverageSpeed(fastestLap.averageSpeed)
            resultEntity.fastestLap = fastestLapEntity
        }

        resultEntity.driver = saveDriver(result.driver)
        resultEntity.constructor = saveConstructor(result.constructor)

        return resultEntity

    }

    private func saveDriver(_ driver: Driver) -> CoreDataDriver {
        let driverEntity = CoreDataDriver(context: context)
        driverEntity.driverID = driver.driverID
        driverEntity.permanentNumber = driver.permanentNumber
        driverEntity.code = driver.code
        driverEntity.url = driver.url
        driverEntity.givenName = driver.givenName
        driverEntity.familyName = driver.familyName
        driverEntity.dateOfBirth = driver.dateOfBirth
        driverEntity.nationality = driver.nationality
        return driverEntity
    }

    private func saveConstructor(_ constructor: Constructor) -> CoreDataConstructor {
        let constructorEntity = CoreDataConstructor(context: context)
        constructorEntity.constructorID = constructor.constructorID
        constructorEntity.url = constructor.url
        constructorEntity.name = constructor.name
        constructorEntity.nationality = constructor.nationality
        return constructorEntity
    }

    private func saveFastestLapTime(_ fastestLapTime: FastestLapTime) -> CoreDataFastestLapTime {
        let fastestLapTimeEntity = CoreDataFastestLapTime(context: context)
        fastestLapTimeEntity.time = fastestLapTime.time
        return fastestLapTimeEntity
    }

    private func saveAverageSpeed(_ averageSpeed: AverageSpeed) -> CoreDataAverageSpeed {
        let averageSpeedEntity = CoreDataAverageSpeed(context: context)
        averageSpeedEntity.units = averageSpeed.units
        averageSpeedEntity.speed = averageSpeed.speed
        return averageSpeedEntity
    }

    private func deleteOldDriverStandingsData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CoreDataDriverStandingsTable.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete old driver standings data: \(error)")
        }
    }

    private func saveDriverStandingsList(_ standingsList: DriverStandingsList) {
        let standingsListEntity = CoreDataDriverStandingsList(context: context)
        standingsListEntity.season = standingsList.season
        standingsListEntity.round = standingsList.round

        for driverStanding in standingsList.driverStandings {
            standingsListEntity.addToDriverStandings(saveDriverStanding(driverStanding))
        }
    }

    private func saveDriverStanding(_ driverStanding: DriverStanding) -> CoreDataDriverStanding {
        let driverStandingEntity = CoreDataDriverStanding(context: context)
        driverStandingEntity.position = driverStanding.position
        driverStandingEntity.positionText = driverStanding.positionText
        driverStandingEntity.points = driverStanding.points
        driverStandingEntity.wins = driverStanding.wins
        driverStandingEntity.driver = saveDriver(driverStanding.driver)

        for constructor in driverStanding.constructors {
            driverStandingEntity.addToConstructor(saveConstructor(constructor))
        }

        return driverStandingEntity
    }

    private func deleteOldConstructorStandingsData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CoreDataConstructorStandingsTable.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete old constructor standings data: \(error)")
        }
    }

    private func saveConstructorStandingsList(_ standingsList: ConstructorStandingsList) {
        let standingsListEntity = CoreDataConstructorStandingsList(context: context)
        standingsListEntity.season = standingsList.season
        standingsListEntity.round = standingsList.round

        for constructorStanding in standingsList.constructorStandings {
            standingsListEntity.addToConstructorStandings(saveConstructorStanding(constructorStanding))
        }
    }

    private func saveConstructorStanding(_ constructorStanding: ConstructorStanding) ->CoreDataConstructorStanding {
        let constructorStandingEntity = CoreDataConstructorStanding(context: context)
        constructorStandingEntity.position = constructorStanding.position
        constructorStandingEntity.positionText = constructorStanding.positionText
        constructorStandingEntity.points = constructorStanding.points
        constructorStandingEntity.wins = constructorStanding.wins
        constructorStandingEntity.constructor = saveConstructor(constructorStanding.constructor)

        return constructorStandingEntity
    }
}
