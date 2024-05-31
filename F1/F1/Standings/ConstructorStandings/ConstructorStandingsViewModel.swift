//
//  ConstructorStandingsViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew.
//
import Foundation

class ConstructorStandingsViewModel {

    // MARK: Variables
    private var repository: ConstructorStandingsRepositoryType?
    var constructorStanding: [ConstructorStanding]?
    var isLoaded = false

    init(repository: ConstructorStandingsRepositoryType) {
        self.repository = repository
    }

    // MARK: Computed Variables
    var constructorCount: Int {
        constructorStanding?.count ?? 0
    }

    // MARK: Functions
    func constructor(atIndex: Int) -> ConstructorStanding? {
        constructorStanding?[atIndex] ?? nil
    }

    func drivers(driversList: [Driver?]) -> String {
        let driverCodes = driversList.compactMap { $0?.code }
        let firstTwoCodes = Array(driverCodes.prefix(2))
        return firstTwoCodes.joined(separator: "/")
    }

    func fetchConstructorStandings(completion: @escaping ([ConstructorStanding]?) -> Void) {
        repository?.fetchConstructorStandingsResults { [weak self] result in
            switch result {
            case .success(let constructorStandings):
                self?.constructorStanding =
                   constructorStandings.constructorStandings.standingsTable.standingsLists.first?.constructorStandings
                self?.sortConstructorStandings()
                self?.isLoaded = true
                completion(self?.constructorStanding)
            case .failure:
                completion(nil)
            }
        }
    }

    private func sortConstructorStandings() {
        constructorStanding =  constructorStanding?.sorted { Int($0.position) ?? 0 < Int($1.position) ?? 0 }
    }
}
