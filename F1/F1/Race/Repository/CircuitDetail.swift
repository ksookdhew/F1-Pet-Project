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

    init(circuitID: String, circuitName: String, url: String, location: Location) {
        self.circuitName = circuitName
        self.circuitID = circuitID
        self.url = url
        self.location = location
    }

    init(from coreDataCircuit: CoreDataCircuit) {
        self.circuitName = coreDataCircuit.circuitName ?? ""
        self.circuitID = coreDataCircuit.circuitID ?? ""
        self.url = coreDataCircuit.url ?? ""
        self.location = Location(from: coreDataCircuit.location!)
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

    init(latitude: String, longitude: String, locality: String, country: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.locality = locality
        self.country = country
    }

    init(from coreDataLocation: CoreDataLocation) {
        self.latitude = coreDataLocation.latitude ?? ""
        self.longitude = coreDataLocation.longitude ?? ""
        self.locality = coreDataLocation.locality ?? ""
        self.country = coreDataLocation.country ?? ""
    }
}
