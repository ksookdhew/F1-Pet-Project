//
//  RaceRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation
typealias RaceResults = (Result< Racing, APIError>) -> Void

protocol RaceRepositoryType: AnyObject {
    func fetchRaceResults(completion: @escaping(RaceResults))
}

class RaceRepository: RaceRepositoryType {

    func fetchRaceResults(completion: @escaping (RaceResults)) {
        let url = Endpoints.racing
        URLSession.shared.request(endpoint: url, method: .GET, completion: completion)
    }
}
