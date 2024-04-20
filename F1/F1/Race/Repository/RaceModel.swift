//
//  RaceModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

// MARK: - RaceModel
struct RaceModel: Codable {
    let mrData: RaceData

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - RaceData
struct RaceData: Codable {
    let xmlns: String
    let series: String
    let url: String
    let limit, offset, total: String
    let raceTable: RaceSheduleTable

    enum CodingKeys: String, CodingKey {
        case xmlns, series, url, limit, offset, total
        case raceTable = "RaceTable"
    }
}

// MARK: - RaceTable
struct RaceSheduleTable: Codable {
    let season: String
    let races: [RaceInfo]

    enum CodingKeys: String, CodingKey {
        case season
        case races = "Races"
    }
}

// MARK: - Race
struct RaceInfo: Codable {
    let season, round: String
    let url: String
    let raceName: String
    let circuit: Circuit
    let date, time: String
    let firstPractice, secondPractice: RaceSessions
    let thirdPractice: RaceSessions?
    let qualifying: RaceSessions
    let sprint: RaceSessions?

    enum CodingKeys: String, CodingKey {
        case season, round, url, raceName
        case circuit = "Circuit"
        case date, time
        case firstPractice = "FirstPractice"
        case secondPractice = "SecondPractice"
        case thirdPractice = "ThirdPractice"
        case qualifying = "Qualifying"
        case sprint = "Sprint"
    }
}

// MARK: - FirstPractice
struct RaceSessions: Codable {
    let date, time: String
}
