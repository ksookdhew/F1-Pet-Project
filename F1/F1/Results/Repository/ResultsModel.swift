//
//  ResultsModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

// MARK: - ResultsModel
struct ResultsModel: Codable {
    let mrData: ResultsData

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - ResultsData
struct ResultsData: Codable {
    let xmlns: String
    let series: String
    let url: String
    let limit, offset, total: String
    let raceTable: RaceTable

    enum CodingKeys: String, CodingKey {
        case xmlns, series, url, limit, offset, total
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
    let season, round: String
    let url: String
    let raceName: String
    let circuit: Circuit
    let date, time: String
    let results: [RacingResult]

    enum CodingKeys: String, CodingKey {
        case season, round, url, raceName
        case circuit = "Circuit"
        case date, time
        case results = "Results"
    }
}

// MARK: - RacingResult
struct RacingResult: Codable {
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
}

// MARK: - AverageSpeed
struct AverageSpeed: Codable {
    let units: Units
    let speed: String
}

enum Units: String, Codable {
    case kph = "kph"
}

// MARK: - FastestLapTime
struct FastestLapTime: Codable {
    let time: String
}

// MARK: - ResultTime
struct ResultTime: Codable {
    let millis, time: String
}
