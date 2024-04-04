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
    private var ConstructorStanding: [ConstructorStanding]?
    
    init(repository: ConstructorStandingsRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    var ConstructorCount: Int {
        return ConstructorStanding?.count ?? 0
    }
    
    func Constructor(atIndex: Int) -> ConstructorStanding? {
        return ConstructorStanding?[atIndex] ?? nil
    }
    
    func fetchConstructorStandings() {
        repository?.fetchConstructorStandingsResults(completion: { [weak self] result in
            switch result {
            case .success(let ConstructorStandings):
                self?.ConstructorStanding = ConstructorStandings.mrData.standingsTable.standingsLists[0].constructorStandings
                print(self?.ConstructorStanding ?? "No Result")
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            } 
        })
    }
}

