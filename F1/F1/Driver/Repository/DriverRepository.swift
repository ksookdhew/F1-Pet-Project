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
}

// MARK: Repository
class DriverRepository: DriverRepositoryType {
    
    func fetchDriverResults(driver: String, completion: @escaping DriverResults) {
        let url = Endpoints.driver + "\(driver)/results.JSON"
        URLSession.shared.request(endpoint: url, method: .GET) { (result: Result<RacingResults, APIError>) in
            switch result {
            case .success(let racingResults):
                CoreDataManager.shared.saveRacingResults(racingResults)
                completion(.success(racingResults))
            case .failure(let error):
                if let savedResults = CoreDataManager.shared.fetchResults() {
                    completion(.success(RacingResults(results: ResultsResponse(
                        series: "F1", url: "", limit: "", offset: "", total: "", raceTable: RaceTable(season: "", races: savedResults)))))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}
