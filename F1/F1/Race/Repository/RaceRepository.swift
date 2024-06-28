//
//  RaceRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation

// MARK: Typealias
typealias RaceResults = (Result< Racing, APIError>) -> Void

// MARK: Protocol
protocol RaceRepositoryType: AnyObject {
    func fetchRaceResults(completion: @escaping RaceResults)
}

// MARK: Repository
class RaceRepository: RaceRepositoryType {
    private let coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }

    func fetchRaceResults(completion: @escaping RaceResults) {
        if let savedRaces = coreDataManager.fetchRaces(), !savedRaces.isEmpty {
            completion(.success(Racing(race: RaceDescriptor(
                series: "F1", url: "", limit: "", offset: "", total: "", raceTable: RaceSheduleTable(season: "", races: savedRaces)))))
        } else {
            let url = Endpoints.racing
            URLSession.shared.request(endpoint: url, method: .GET) { [weak self] (result: Result<Racing, APIError>) in
                switch result {
                case .success(let races):
                    self?.coreDataManager.saveRaceInfo(races)
                    completion(.success(races))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
