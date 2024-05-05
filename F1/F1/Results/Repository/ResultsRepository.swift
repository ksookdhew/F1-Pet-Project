//
//  ResultsRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation
typealias ResultsResults = (Result< RacingResults, APIError>) -> Void

protocol ResultsRepositoryType: AnyObject {
    func fetchRoundResults(round: String, completion: @escaping(ResultsResults))
    func fetchRacingResults(completion: @escaping(ResultsResults))
}

class ResultsRepository: ResultsRepositoryType {
    func fetchRoundResults(round: String, completion: @escaping (ResultsResults)) {
        let url = "https://ergast.com/api/f1/current/\(round)/results.JSON"
        URLSession.shared.request(endpoint: url, method: .GET, completion: completion)
    }
    func fetchRacingResults(completion: @escaping (ResultsResults)) {
        let url = "https://ergast.com/api/f1/current/results.JSON?limit=100"
        URLSession.shared.request(endpoint: url, method: .GET, completion: completion)
    }
}
