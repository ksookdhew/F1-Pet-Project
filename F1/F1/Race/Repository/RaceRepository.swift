//
//  RaceRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation
typealias RaceResult = (Result< Racing, APIError>) -> Void

protocol RaceRepositoryType: AnyObject {
    func fetchRaceResults(completion: @escaping(RaceResult))
}

class RaceRepository: RaceRepositoryType {

    func fetchRaceResults(completion: @escaping (RaceResult)) {
        let url = Endpoints.racing
        URLSession.shared.request(endpoint: url, method: .GET, completion: completion)
    }
}
