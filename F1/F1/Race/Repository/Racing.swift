//
//  RaceModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

// MARK: - Racing
struct Racing: Codable {
    let race: RaceDescriptor

    enum CodingKeys: String, CodingKey {
        case race = "MRData"
    }
}

// MARK: - RaceDescriptor
struct RaceDescriptor: Codable {
    let series: String
    let url: String
    let limit, offset, total: String
    let raceTable: RaceSheduleTable

    enum CodingKeys: String, CodingKey {
        case series, url, limit, offset, total
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
    let firstPractice, secondPractice: RaceSession
    let thirdPractice: RaceSession?
    let qualifying: RaceSession
    let sprint: RaceSession?

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

// MARK: - RaceSessions
struct RaceSession: Codable {
    let date, time: String
}

// MARK: - SessionType
enum SessionType: String {
    case race = "Race"
    case practice1 = "Practice 1"
    case qualifying = "Qualifying"
    case practice2 = "Practice 2"
    case practice3 = "Practice 3"
    case sprintQualifying = "Sprint Qualifying"
    case sprint = "Sprint"
}

// MARK: - RaceSessionDetail
struct RaceSessionDetail {
    let date: String
    let time: String
    let type: SessionType

}
