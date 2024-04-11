//
//  ConstructorStandingsModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/03/27.
//
import Foundation

// MARK: - ConstructorStandingsModel
struct ConstructorStandingsModel: Codable {
    let mrData: ConstructorStandingsData

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - ConstructorStandingsData
struct ConstructorStandingsData: Codable {
    let xmlns: String
    let series: String
    let url: String
    let limit, offset, total: String
    let standingsTable: ConstructorStandingsTable

    enum CodingKeys: String, CodingKey {
        case xmlns, series, url, limit, offset, total
        case standingsTable = "StandingsTable"
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
}

// MARK: - ConstructorStandingsList
struct ConstructorStandingsList: Codable {
    let season, round: String
    let constructorStandings: [ConstructorStanding]

    enum CodingKeys: String, CodingKey {
        case season, round
        case constructorStandings = "ConstructorStandings"
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
}