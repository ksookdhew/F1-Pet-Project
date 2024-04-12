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
    private var driverDic: [String: [Driver?]] = [:]

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

    func setDriver(constructor: String, driver: Driver) {

        if var drivers = driverDic[constructor] {
            drivers.append(driver)
            driverDic[constructor] = drivers
        } else {
            driverDic[constructor] = [driver]
        }
    }

    
    func getDrivers(constructorID: String) -> [Driver?]? {
        return driverDic[constructorID] ?? []
    }

    func fetchConstructorStandings() {
        repository?.fetchConstructorStandingsResults(completion: { [weak self] result in
            switch result {
            case .success(let constructorStandings):
                self?.constructorStanding = constructorStandings.mrData.standingsTable.standingsLists[0].constructorStandings
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        })
    }
}
