//
//  ResultsRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation

// MARK: Typealias
typealias ResultsResults = (Result< RacingResults, APIError>) -> Void

// MARK: Protocol
protocol ResultsRepositoryType: AnyObject {
    func fetchRacingResults(completion: @escaping(ResultsResults))
}

// MARK: Repository
class ResultsRepository: ResultsRepositoryType {

    func fetchRacingResults(completion: @escaping (ResultsResults)) {
        let url = Endpoints.racingResults
        URLSession.shared.request(endpoint: url, method: .GET) { (result: Result<RacingResults, APIError>) in
            switch result {
            case .success(let results):
                CoreDataManager.shared.saveRacingResults(results)
                completion(.success(results))
            case .failure(let error):
                if let savedResults = CoreDataManager.shared.fetchResults(), !savedResults.isEmpty {
                    Flags.offline = true
                    completion(.success(RacingResults(results: ResultsResponse(
                        series: "F1", url: "", limit: "", offset: "", total: "", raceTable: RaceTable(season: "", races: savedResults)))))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}
