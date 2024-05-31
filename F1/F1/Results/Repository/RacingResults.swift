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
    var results: [RaceResult]

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

    init(season: String, round: String, url: String,
         raceName: String, circuit: Circuit, date: String,
         time: String, results: [RaceResult]) {
        self.season = season
        self.round = round
        self.url = url
        self.raceName = raceName
        self.circuit = circuit
        self.date = date
        self.time = time
        self.results = results
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

    init(number: String, position: String, positionText: String, points: String,
         driver: Driver, constructor: Constructor, grid: String, laps: String, status: String,
         time: ResultTime?, fastestLap: FastestLap?) {
        self.number = number
        self.position = position
        self.positionText = positionText
        self.points = points
        self.driver = driver
        self.constructor = constructor
        self.grid = grid
        self.laps = laps
        self.status = status
        self.time = time
        self.fastestLap = fastestLap
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

    init(rank: String, lap: String, time: FastestLapTime, averageSpeed: AverageSpeed) {
        self.rank = rank
        self.lap = lap
        self.time = time
        self.averageSpeed = averageSpeed
    }
}

// MARK: - AverageSpeed
struct AverageSpeed: Codable {
    let units, speed: String

    init(from coreDataAverageSpeed: CoreDataAverageSpeed) {
        self.units = coreDataAverageSpeed.units ?? ""
        self.speed = coreDataAverageSpeed.speed ?? ""
    }

    init(units: String, speed: String) {
        self.units = units
        self.speed = speed
    }
}

// MARK: - FastestLapTime
struct FastestLapTime: Codable {
    let time: String

    init(from coreDataFastestLapTime: CoreDataFastestLapTime) {
        self.time = coreDataFastestLapTime.time ?? ""
    }

    init(time: String) {
        self.time = time
    }
}

// MARK: - ResultTime
struct ResultTime: Codable {
    let millis, time: String

    init(from coreDataResultTime: CoreDataResultTime) {
        self.millis = coreDataResultTime.millis ?? ""
        self.time = coreDataResultTime.time ?? ""
    }

    init(millis: String, time: String) {
        self.millis = millis
        self.time = time
    }
}
