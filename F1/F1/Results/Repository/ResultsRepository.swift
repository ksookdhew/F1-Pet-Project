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
        let url = Endpoints.racingResults
        URLSession.shared.request(endpoint: url, method: .GET, completion: completion)
    }
}
