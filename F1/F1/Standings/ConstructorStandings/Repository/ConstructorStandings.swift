//
//  ConstructorStandingsModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/03/27.
//
import Foundation

// MARK: - ConstructorStandingsModel
struct ConstructorStandingsModel: Codable {
    let constructorStandings: ConstructorStandingsResponse

    enum CodingKeys: String, CodingKey {
        case constructorStandings = "MRData"
    }

    init(from coreDataConstructorStandingsTable: CoreDataConstructorStandingsTable) {
        self.constructorStandings = ConstructorStandingsResponse(from: coreDataConstructorStandingsTable)
    }

    init(constructorStandings: ConstructorStandingsResponse) {
        self.constructorStandings = constructorStandings
    }
}

// MARK: - ConstructorStandingsResponse
struct ConstructorStandingsResponse: Codable {
    let series, url, limit, offset, total: String
    let standingsTable: ConstructorStandingsTable

    enum CodingKeys: String, CodingKey {
        case series, url, limit, offset, total
        case standingsTable = "StandingsTable"
    }

    init(from coreDataConstructorStandingsTable: CoreDataConstructorStandingsTable) {
        self.series = "F1"
        self.url = ""
        self.limit = ""
        self.offset = ""
        self.total = ""
        self.standingsTable = ConstructorStandingsTable(from: coreDataConstructorStandingsTable)
    }

    init(series: String, url: String, limit: String, offset: String, total: String, standingsTable: ConstructorStandingsTable) {
        self.series = series
        self.url = url
        self.limit = limit
        self.offset = offset
        self.total = total
        self.standingsTable = standingsTable
    }
}

// MARK: - ConstructorStandingsTable
struct ConstructorStandingsTable: Codable {
    let season: String
    let standingsLists: [ConstructorStandingsList]

    enum CodingKeys: String, CodingKey {
        case season
        case standingsLists = "StandingsLists"
    }

    init(from coreDataConstructorStandingsTable: CoreDataConstructorStandingsTable) {
        self.season = coreDataConstructorStandingsTable.season ?? ""
        self.standingsLists = (coreDataConstructorStandingsTable.standingsLists?.allObjects as? [CoreDataConstructorStandingsList])?.map { ConstructorStandingsList(from: $0) } ?? []
    }

    init(season: String, standingsLists: [ConstructorStandingsList]) {
        self.season = season
        self.standingsLists = standingsLists
    }
}

// MARK: - ConstructorStandingsList
struct ConstructorStandingsList: Codable {
    let season, round: String
    let constructorStandings: [ConstructorStanding]

    enum CodingKeys: String, CodingKey {
        case season, round
        case constructorStandings = "ConstructorStandings"
    }

    init(from coreDataConstructorStandingsList: CoreDataConstructorStandingsList) {
        self.season = coreDataConstructorStandingsList.season ?? ""
        self.round = coreDataConstructorStandingsList.round ?? ""
        self.constructorStandings = (coreDataConstructorStandingsList.constructorStandings?.allObjects as? [CoreDataConstructorStanding])?.map { ConstructorStanding(from: $0) } ?? []
    }

    init(season: String, round: String, constructorStandings: [ConstructorStanding]) {
        self.season = season
        self.round = round
        self.constructorStandings = constructorStandings
    }
}

// MARK: - ConstructorStanding
struct ConstructorStanding: Codable {
    let position, positionText, points, wins: String
    let constructor: Constructor

    enum CodingKeys: String, CodingKey {
        case position, positionText, points, wins
        case constructor = "Constructor"
    }

    init(from coreDataConstructorStanding: CoreDataConstructorStanding) {
        self.position = coreDataConstructorStanding.position ?? ""
        self.positionText = coreDataConstructorStanding.positionText ?? ""
        self.points = coreDataConstructorStanding.points ?? ""
        self.wins = coreDataConstructorStanding.wins ?? ""
        self.constructor = Constructor(from: coreDataConstructorStanding.constructor!)
    }

    init(position: String, positionText: String, points: String, wins: String, constructor: Constructor) {
        self.position = position
        self.positionText = positionText
        self.points = points
        self.wins = wins
        self.constructor = constructor
    }
}
