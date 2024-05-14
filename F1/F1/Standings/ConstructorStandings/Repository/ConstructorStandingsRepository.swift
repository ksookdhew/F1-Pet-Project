//
//  ConstructorStandingsRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation

// MARK: Typealias
typealias ConstructorStandingsResults = (Result< ConstructorStandingsModel, APIError>) -> Void

// MARK: Protocol
protocol ConstructorStandingsRepositoryType: AnyObject {
    func fetchConstructorStandingsResults(completion: @escaping(ConstructorStandingsResults))
}

// MARK: Repository
class ConstructorStandingsRepository: ConstructorStandingsRepositoryType {

    func fetchConstructorStandingsResults(completion: @escaping (ConstructorStandingsResults)) {
        URLSession.shared.request(endpoint:
                                    Endpoints.constructorStanding, method: .GET, completion: completion)
    }

}
