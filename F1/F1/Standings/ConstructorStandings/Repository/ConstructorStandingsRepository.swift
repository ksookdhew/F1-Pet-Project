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
    func fetchConstructorStandingsResultsOffline(completion: @escaping(ConstructorStandingsResults))
}

// MARK: Repository
class ConstructorStandingsRepository: ConstructorStandingsRepositoryType {
    private let coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }

    func fetchConstructorStandingsResults(completion: @escaping (ConstructorStandingsResults)) {
        let url = Endpoints.constructorStanding
        URLSession.shared.request(endpoint: url, method: .GET) { (result: Result<ConstructorStandingsModel, APIError>) in
            switch result {
            case .success(let constructorStandingsModel):
                self.coreDataManager.saveConstructorStandings(constructorStandingsModel)
                completion(.success(constructorStandingsModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchConstructorStandingsResultsOffline(completion: @escaping (ConstructorStandingsResults)) {
        if let savedStandings = coreDataManager.fetchConstructorStandings() {
            completion(.success(savedStandings))
        } else {
            completion(.failure(.offlineError))
        }
    }
}
