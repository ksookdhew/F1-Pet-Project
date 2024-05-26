//
//  ConstructorStandingsViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew.
//
import Foundation

class ConstructorStandingsViewModel {

    // MARK: Variables
    private weak var delegate: ViewModelDelegate?
    private var repository: ConstructorStandingsRepositoryType?
    private var constructorStanding: [ConstructorStanding]?
    var isLoaded = false

    init(repository: ConstructorStandingsRepositoryType, delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
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

    func fetchConstructorStandings() {
        isLoaded = true
        repository?.fetchConstructorStandingsResults { [weak self] result in
            switch result {
            case .success(let constructorStandings):
                self?.constructorStanding = constructorStandings.constructorStandings.standingsTable.standingsLists.first?.constructorStandings
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
}
