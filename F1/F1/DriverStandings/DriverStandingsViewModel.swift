//
//  DriverStandingsViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func reloadView()
    func show(error: String)
}

class DriverStandingsViewModel {
    
    private var repository: F1RepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var DriverStanding: [DriverStanding]?
    
    init(repository: F1RepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    var DriversCount: Int {
        return DriverStanding?.count ?? 0
    }
    
    func Driver(atIndex: Int) -> DriverStanding? {
        return DriverStanding?[atIndex] ?? nil
    }
    
    func fetchDriverStandings() {
        repository?.fetchDriverStandingsResults(completion: { [weak self] result in
            switch result {
            case .success(let driverStandings):
                self?.DriverStanding = driverStandings.mrData.standingsTable.standingsLists[0].driverStandings
                print(self?.DriverStanding ?? "No Results")
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        })
    }
}
