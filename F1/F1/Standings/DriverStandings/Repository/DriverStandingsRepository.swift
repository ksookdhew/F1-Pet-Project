//
//  DriverStandingsRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation

// MARK: Typealias
typealias DriverStandingsResults = (Result< DriverStandingsModel, APIError>) -> Void

// MARK: Protocol
protocol DriverStandingsRepositoryType: AnyObject {
    func fetchDriverStandingsResults(completion: @escaping(DriverStandingsResults))
}

// MARK: Repository
class DriverStandingsRepository: DriverStandingsRepositoryType {

    func fetchDriverStandingsResults(completion: @escaping (DriverStandingsResults)) {
        URLSession.shared.request(endpoint:
                                    Endpoints.driverStanding, method: .GET, completion: completion)
    }
}
