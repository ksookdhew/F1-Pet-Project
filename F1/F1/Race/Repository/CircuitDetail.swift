//
//  CircuitModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

// MARK: - CircuitDetails
struct CircuitDetail: Codable {
    let circuit: CircuitInfo

    enum CodingKeys: String, CodingKey {
        case circuit = "MRData"
    }
}

// MARK: - CircuitInfo
struct CircuitInfo: Codable {
    let series, url, limit, offset, total: String
    let circuitTable: CircuitTable

    enum CodingKeys: String, CodingKey {
        case series, url, limit, offset, total
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
    let circuitID, url, circuitName: String
    let location: Location

    enum CodingKeys: String, CodingKey {
        case circuitID = "circuitId"
        case url, circuitName
        case location = "Location"
    }
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude, locality, country: String

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "long"
        case locality, country
    }
}
