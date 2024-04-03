//
//  CircuitModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

// MARK: - CircuitModel
struct CircuitModel: Codable {
    let mrData: CircuitData
 
    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - CircuitData
struct CircuitData: Codable {
    let xmlns: String
    let series: String
    let url: String
    let limit, offset, total: String
    let circuitTable: CircuitTable

    enum CodingKeys: String, CodingKey {
        case xmlns, series, url, limit, offset, total
        case circuitTable = "CircuitTable"
    }
}

// MARK: - CircuitTable
struct CircuitTable: Codable {
    let circuits: [Circuit]

    enum CodingKeys: String, CodingKey {
        case circuits = "Circuits"
    }
}

// MARK: - Circuit
struct Circuit: Codable {
    let circuitID: String
    let url: String
    let circuitName: String
    let location: Location

    enum CodingKeys: String, CodingKey {
        case circuitID = "circuitId"
        case url, circuitName
        case location = "Location"
    }
}

// MARK: - Location
struct Location: Codable {
    let lat, long, locality, country: String
}

