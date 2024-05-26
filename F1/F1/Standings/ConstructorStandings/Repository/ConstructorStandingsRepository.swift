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
        let url = Endpoints.constructorStanding
        URLSession.shared.request(endpoint: url, method: .GET) { (result: Result<ConstructorStandingsModel, APIError>) in
            switch result {
            case .success(let constructorStandingsModel):
                CoreDataManager.shared.saveConstructorStandings(constructorStandingsModel)
                completion(.success(constructorStandingsModel))
            case .failure(let error):
                if let savedStandings = CoreDataManager.shared.fetchConstructorStandings() {
                    completion(.success(savedStandings))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}
