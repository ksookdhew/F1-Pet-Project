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
    private weak var delegate: ViewModelDelegate?
    private var constructorStanding: [ConstructorStanding]?

    init(repository: ConstructorStandingsRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: Computed Variables
    var constructorCount: Int {
        return constructorStanding?.count ?? 0
    }

    // MARK: Functions
    func constructor(atIndex: Int) -> ConstructorStanding? {
        return constructorStanding?[atIndex] ?? nil
    }

    func drivers(driversList: [Driver?]) -> String {
        if driversList.count >= 1 {
            if driversList.count >= 2 {
                return "\(driversList.first??.code ?? "")/\(driversList[1]?.code ?? "")"
            } else {
                return"\(driversList.first??.code ?? "")"
            }
        } else {
            return ""
        }
    }

    func fetchConstructorStandings() {
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
