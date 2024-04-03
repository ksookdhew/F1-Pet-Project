//
//  DriverStandingsRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation

typealias DriverStandingsResults = (Result< DriverStandingsModel, APIError>) -> Void

protocol DriverStandingsRepositoryType: AnyObject {
    
    func fetchDriverStandingsResults(completion: @escaping(DriverStandingsResults))
}

class DriverStandingsRepository: DriverStandingsRepositoryType {
    
    func fetchDriverStandingsResults(completion: @escaping (DriverStandingsResults)) {
        URLSession.shared.request(endpoint: "https://ergast.com/api/f1/current/driverStandings.JSON", method: .GET, completion: completion)
    }
    
}

