//
//  ConstructorStandingsRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation

typealias ConstructorStandingsResults = (Result< ConstructorStandingsModel, APIError>) -> Void

protocol ConstructorStandingsRepositoryType: AnyObject {
    func fetchConstructorStandingsResults(completion: @escaping(ConstructorStandingsResults))
}

class ConstructorStandingsRepository: ConstructorStandingsRepositoryType {

    func fetchConstructorStandingsResults(completion: @escaping (ConstructorStandingsResults)) {
        URLSession.shared.request(endpoint:
        "https:ergast.com/api/f1/current/constructorStandings.JSON", method: .GET, completion: completion)
    }

}
