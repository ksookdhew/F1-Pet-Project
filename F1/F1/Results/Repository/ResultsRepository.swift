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
    func fetchRoundResults(round: String, completion: @escaping(ResultsResults))
    func fetchRacingResults(completion: @escaping(ResultsResults))
}

// MARK: Repository
class ResultsRepository: ResultsRepositoryType {

    func fetchRoundResults(round: String, completion: @escaping (ResultsResults)) {
        let url = Endpoints.roundResult + "\(round)/results.JSON"
        URLSession.shared.request(endpoint: url, method: .GET, completion: completion)
    }

    func fetchRacingResults(completion: @escaping (ResultsResults)) {
        if let savedResults = CoreDataManager.shared.fetchResults(), !savedResults.isEmpty {
            completion(.success(RacingResults(results: ResultsResponse(
                series: "F1", url: "", limit: "", offset: "", total: "", raceTable: RaceTable(season: "", races: savedResults)))))
        } else {
            let url = Endpoints.racingResults
            URLSession.shared.request(endpoint: url, method: .GET) { [weak self] (result: Result<RacingResults, APIError>) in
                switch result {
                case .success(let results):
                    CoreDataManager.shared.saveRacingResults(results)
                    completion(.success(results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

