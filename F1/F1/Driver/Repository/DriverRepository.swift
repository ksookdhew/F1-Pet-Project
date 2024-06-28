//
//  DriverRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation

// MARK: Typealias
typealias DriverResults = (Result< RacingResults, APIError>) -> Void

// MARK: Protocol
protocol DriverRepositoryType: AnyObject {
    func fetchDriverResults(driver: String, completion: @escaping DriverResults)
    func fetchDriverResultsOffline(driver: String, completion: @escaping DriverResults)
}

// MARK: Repository
class DriverRepository: DriverRepositoryType {
    private let coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }

    func fetchDriverResults(driver: String, completion: @escaping DriverResults) {
        let url = Endpoints.driver + "\(driver)/results.JSON"
        URLSession.shared.request(endpoint: url, method: .GET) { (result: Result<RacingResults, APIError>) in
            switch result {
            case .success(let racingResults):
                self.coreDataManager.saveRacingResults(racingResults)
                completion(.success(racingResults))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchDriverResultsOffline(driver: String, completion: @escaping DriverResults) {
        if let savedResults = coreDataManager.fetchResults() {
            completion(.success(RacingResults(results: ResultsResponse(
                series: "F1", url: "", limit: "", offset: "", total: "", raceTable: RaceTable(season: "", races: savedResults)))))
        } else {
            completion(.failure(.offlineError))
        }
    }
}
