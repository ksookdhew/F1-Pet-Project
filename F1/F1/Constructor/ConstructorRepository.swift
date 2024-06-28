//
//  ConstructorRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

// MARK: Typealias
typealias ConstructorResults = (Result<RacingResults, APIError>) -> Void

// MARK: Protocol
protocol ConstructorRepositoryType: AnyObject {
    func fetchConstructorResults(constructor: String, completion: @escaping ConstructorResults)
    func fetchConstructorResultsOffline(constructor: String, completion: @escaping ConstructorResults)

}

// MARK: Repository
class ConstructorRepository: ConstructorRepositoryType {
    private let coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }

    func fetchConstructorResults(constructor: String, completion: @escaping ConstructorResults) {
        let url = Endpoints.constructor + "\(constructor)/results.JSON"
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

    func fetchConstructorResultsOffline(constructor: String, completion: @escaping ConstructorResults) {
        if let savedResults = coreDataManager.fetchResults() {
            completion(.success(RacingResults(results: ResultsResponse(
                series: "F1", url: "", limit: "", offset: "", total: "", raceTable: RaceTable(season: "", races: savedResults)))))
        } else {
            completion(.failure(.offlineError))
        }
    }
}
