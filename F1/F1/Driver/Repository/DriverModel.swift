//
//  DriverModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/03/28.
//

import Foundation

// MARK: - DriverModel
struct DriverModel: Codable {
    let driver: DriverResponse

    enum CodingKeys: String, CodingKey {
        case driver = "MRData"
    }
}

// MARK: - DriverData
struct DriverResponse: Codable {
    let series: String
    let url: String
    let limit, offset, total: String
    let driverTable: DriverTable

    enum CodingKeys: String, CodingKey {
        case series, url, limit, offset, total
        case driverTable = "DriverTable"
    }
}

// MARK: - DriverTable
struct DriverTable: Codable {
    let driverID: String
    let drivers: [Driver]

    enum CodingKeys: String, CodingKey {
        case driverID = "driverId"
        case drivers = "Drivers"
    }
}

// MARK: - Driver
struct Driver: Codable {
    let driverID, permanentNumber, code: String
    let url: String
    let givenName, familyName, dateOfBirth, nationality: String

    enum CodingKeys: String, CodingKey {
        case driverID = "driverId"
        case permanentNumber, code, url, givenName, familyName, dateOfBirth, nationality
    }
}
