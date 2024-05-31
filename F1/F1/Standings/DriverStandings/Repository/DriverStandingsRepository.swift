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

    func fetchDriverStandingsResults(completion: @escaping(DriverStandingsResults)) {
        let url = Endpoints.driverStanding
        URLSession.shared.request(endpoint: url, method: .GET) { (result: Result<DriverStandingsModel, APIError>) in
            switch result {
            case .success(let driverStandingsModel):
                Flags.offline = false
                CoreDataManager.shared.saveDriverStandings(driverStandingsModel)
                completion(.success(driverStandingsModel))
            case .failure(let error):
                if let savedStandings = CoreDataManager.shared.fetchDriverStandings() {
                    Flags.offline = true
                    completion(.success(savedStandings))
                } else {
                    Flags.offline = true
                    completion(.failure(error))
                }
            }
        }
    }
}
