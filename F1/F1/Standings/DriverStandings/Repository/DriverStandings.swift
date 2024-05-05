//
//  DriverStandingsModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/03/27.
//
import Foundation

// MARK: - DriverStandingsModel
struct DriverStandingsModel: Codable {
    let driverStandings: DriverStandingsResponse

    enum CodingKeys: String, CodingKey {
        case driverStandings = "MRData"
    }
}

// MARK: - Data
struct DriverStandingsResponse: Codable {
    let series: String
    let url: String
    let limit, offset, total: String
    let standingsTable: DriverStandingsTable

    enum CodingKeys: String, CodingKey {
        case series, url, limit, offset, total
        case standingsTable = "StandingsTable"
    }
}

// MARK: - DriverStandingsTable
struct DriverStandingsTable: Codable {
    let season: String
    let standingsLists: [DriverStandingsList]

    enum CodingKeys: String, CodingKey {
        case season
        case standingsLists = "StandingsLists"
    }
}

// MARK: - DriverStandingsList
struct DriverStandingsList: Codable {
    let season, round: String
    let driverStandings: [DriverStanding]

    enum CodingKeys: String, CodingKey {
        case season, round
        case driverStandings = "DriverStandings"
    }
}

// MARK: - DriverStanding
struct DriverStanding: Codable {
    let position, positionText, points, wins: String
    let driver: Driver
    let constructors: [Constructor]

    enum CodingKeys: String, CodingKey {
        case position, positionText, points, wins
        case driver = "Driver"
        case constructors = "Constructors"
    }
}
