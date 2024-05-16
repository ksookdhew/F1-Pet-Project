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

// MARK: - DriverResponse
struct DriverResponse: Codable {
    let series, url, limit, offset, total: String
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
    let driverID, permanentNumber, code, url, givenName, familyName, dateOfBirth, nationality: String

    enum CodingKeys: String, CodingKey {
        case driverID = "driverId"
        case permanentNumber, code, url, givenName, familyName, dateOfBirth, nationality
    }

    init(from coreDataDriver: CoreDataDriver) {
        self.driverID = coreDataDriver.driverID ?? ""
        self.permanentNumber = coreDataDriver.permanentNumber ?? ""
        self.code = coreDataDriver.code ?? ""
        self.url = coreDataDriver.url ?? ""
        self.givenName = coreDataDriver.givenName ?? ""
        self.familyName = coreDataDriver.familyName ?? ""
        self.dateOfBirth = coreDataDriver.dateOfBirth ?? ""
        self.nationality = coreDataDriver.nationality ?? ""
    }
}
