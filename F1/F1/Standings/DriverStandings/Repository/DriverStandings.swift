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

    init(from coreDataDriverStandingsTable: CoreDataDriverStandingsTable) {
        self.driverStandings = DriverStandingsResponse(from: coreDataDriverStandingsTable)
    }

    init(driverStandings: DriverStandingsResponse) {
            self.driverStandings = driverStandings
    }
}

// MARK: - DriverStandingsResponse
struct DriverStandingsResponse: Codable {
    let series, url, limit, offset, total: String
    let standingsTable: DriverStandingsTable

    enum CodingKeys: String, CodingKey {
        case series, url, limit, offset, total
        case standingsTable = "StandingsTable"
    }

    init(from coreDataDriverStandingsTable: CoreDataDriverStandingsTable) {
        self.series = "F1"
        self.url = ""
        self.limit = ""
        self.offset = ""
        self.total = ""
        self.standingsTable = DriverStandingsTable(from: coreDataDriverStandingsTable)
    }

    init(series: String, url: String, limit: String,
         offset: String, total: String, standingsTable: DriverStandingsTable) {
        self.series = series
        self.url = url
        self.limit = limit
        self.offset = offset
        self.total = total
        self.standingsTable = standingsTable
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

    init(from coreDataDriverStandingsTable: CoreDataDriverStandingsTable) {
        self.season = coreDataDriverStandingsTable.season ?? ""
        self.standingsLists = coreDataDriverStandingsTable.standingsList?.allObjects.compactMap {
            ($0 as? CoreDataDriverStandingsList).map(DriverStandingsList.init) } ?? []
    }

    init(season: String, standingsLists: [DriverStandingsList]) {
        self.season = season
        self.standingsLists = standingsLists
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

    init(from coreDataDriverStandingsList: CoreDataDriverStandingsList) {
        self.season = coreDataDriverStandingsList.season ?? ""
        self.round = coreDataDriverStandingsList.round ?? ""
        self.driverStandings = coreDataDriverStandingsList.driverStandings?.allObjects.compactMap {
            ($0 as? CoreDataDriverStanding).map(DriverStanding.init) } ?? []
    }

    init(season: String, round: String, driverStandings: [DriverStanding]) {
        self.season = season
        self.round = round
        self.driverStandings = driverStandings
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

    init(from coreDataDriverStanding: CoreDataDriverStanding) {
        self.position = coreDataDriverStanding.position ?? ""
        self.positionText = coreDataDriverStanding.positionText ?? ""
        self.points = coreDataDriverStanding.points ?? ""
        self.wins = coreDataDriverStanding.wins ?? ""
        self.driver = Driver(from: coreDataDriverStanding.driver!)
        self.constructors = coreDataDriverStanding.constructor?.allObjects.compactMap {
            ($0 as? CoreDataConstructor).map(Constructor.init) } ?? []
    }

    init(position: String, positionText: String, points: String,
         wins: String, driver: Driver, constructors: [Constructor]) {
        self.position = position
        self.positionText = positionText
        self.points = points
        self.wins = wins
        self.driver = driver
        self.constructors = constructors
    }
}
