//
//  ConstructorStandingsViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew.
//
import Foundation

class ConstructorStandingsViewModel {

    private var repository: ConstructorStandingsRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var constructorStanding: [ConstructorStanding]?

    init(repository: ConstructorStandingsRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }

    var constructorCount: Int {
        return constructorStanding?.count ?? 0
    }

    func constructor(atIndex: Int) -> ConstructorStanding? {
        return constructorStanding?[atIndex] ?? nil
    }

    func fetchConstructorStandings() {
        repository?.fetchConstructorStandingsResults { [weak self] result in
            switch result {
            case .success(let constructorStandings):
                self?.constructorStanding = constructorStandings.constructorStandings.standingsTable.standingsLists[0].constructorStandings
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
}
