//
//  ResultsModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

// MARK: - RacingResults
struct RacingResults: Codable {
    let results: ResultsResponse

    enum CodingKeys: String, CodingKey {
        case results = "MRData"
    }
}

// MARK: - ResultsResponse
struct ResultsResponse: Codable {
    let series, url, limit, offset, total: String
    let raceTable: RaceTable

    enum CodingKeys: String, CodingKey {
        case series, url, limit, offset, total
        case raceTable = "RaceTable"
    }
}

// MARK: - RaceTable
struct RaceTable: Codable {
    let season: String
    let races: [Race]

    enum CodingKeys: String, CodingKey {
        case season
        case races = "Races"
    }
}

// MARK: - Race
struct Race: Codable {
    let season, round, url, raceName: String
    let circuit: Circuit
    let date, time: String
    let results: [RaceResult]

    enum CodingKeys: String, CodingKey {
        case season, round, url, raceName
        case circuit = "Circuit"
        case date, time
        case results = "Results"
    }

    init(from coreDataRace: CoreDataRace) {
            self.season = coreDataRace.season ?? ""
            self.round = coreDataRace.round ?? ""
            self.url = coreDataRace.url ?? ""
            self.raceName = coreDataRace.raceName ?? ""
            self.date = coreDataRace.date ?? ""
            self.time = coreDataRace.time ?? ""
            self.circuit = Circuit(from: coreDataRace.circuit!)
            self.results = coreDataRace.results?.allObjects.compactMap {
            ($0 as? CoreDataRaceResult).map(RaceResult.init) } ?? []
        }
}

// MARK: - RaceResult
struct RaceResult: Codable {
    let number, position, positionText, points: String
       let driver: Driver
       let constructor: Constructor
       let grid, laps: String
       let status: String
       let time: ResultTime?
       let fastestLap: FastestLap?

       enum CodingKeys: String, CodingKey {
           case number, position, positionText, points
           case driver = "Driver"
           case constructor = "Constructor"
           case grid, laps, status
           case time = "Time"
           case fastestLap = "FastestLap"
       }

    init(from coreDataRaceResult: CoreDataRaceResult) {
        self.number = coreDataRaceResult.number ?? ""
        self.position = coreDataRaceResult.position ?? ""
        self.positionText = coreDataRaceResult.positionText ?? ""
        self.points = coreDataRaceResult.points ?? ""
        self.grid = coreDataRaceResult.grid ?? ""
        self.laps = coreDataRaceResult.laps ?? ""
        self.status = coreDataRaceResult.status ?? ""
        self.time = coreDataRaceResult.time.map(ResultTime.init)
        self.fastestLap = coreDataRaceResult.fastestLap.map(FastestLap.init)
        self.driver = Driver(from: coreDataRaceResult.driver!)
        self.constructor = Constructor(from: coreDataRaceResult.constructor!)
    }
}

// MARK: - FastestLap
struct FastestLap: Codable {
    let rank, lap: String
    let time: FastestLapTime
    let averageSpeed: AverageSpeed

    enum CodingKeys: String, CodingKey {
        case rank, lap
        case time = "Time"
        case averageSpeed = "AverageSpeed"
    }

    init(from coreDataFastestLap: CoreDataFastestLap) {
        self.rank = coreDataFastestLap.rank ?? ""
        self.lap = coreDataFastestLap.lap ?? ""
        self.time = FastestLapTime(from: coreDataFastestLap.time!)
        self.averageSpeed = AverageSpeed(from: coreDataFastestLap.averageSpeed!)
    }
}

// MARK: - AverageSpeed
struct AverageSpeed: Codable {
    let units, speed: String
    
    init(from coreDataAverageSpeed: CoreDataAverageSpeed) {
        self.units = coreDataAverageSpeed.units ?? ""
        self.speed = coreDataAverageSpeed.speed ?? ""
    }
}

// MARK: - FastestLapTime
struct FastestLapTime: Codable {
    let time: String

    init(from coreDataFastestLapTime: CoreDataFastestLapTime) {
        self.time = coreDataFastestLapTime.time ?? ""
    }
}

// MARK: - ResultTime
struct ResultTime: Codable {
    let millis, time: String

    init(from coreDataResultTime: CoreDataResultTime) {
        self.millis = coreDataResultTime.millis ?? ""
        self.time = coreDataResultTime.time ?? ""
    }
}
