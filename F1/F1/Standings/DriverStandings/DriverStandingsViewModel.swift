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

    private var repository: DriverStandingsRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var driverStanding: [DriverStanding]?
    var driverDic: [String: [Driver?]] = [:]

    init(repository: DriverStandingsRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }

    var driversCount: Int {
        return driverStanding?.count ?? 0
    }

    func driver(atIndex: Int) -> DriverStanding? {
        return driverStanding?[atIndex] ?? nil
    }

    func setConstructors() {

        if let driverSt = driverStanding {
            for driver in driverSt {
                let constructor = driver.constructors[0].constructorID
                if var drivers = driverDic[constructor] {
                    drivers.append(driver.driver)
                    driverDic[constructor] = drivers
                } else {
                    driverDic[constructor] = [driver.driver]
                }
            }
        } else {

        }

    }

    func getConstructorDrivers(constructorID: String) -> [Driver?]? {
        return driverDic[constructorID] ?? []
    }

    func fetchDriverStandings() {
        repository?.fetchDriverStandingsResults(completion: { [weak self] result in
            switch result {
            case .success(let driverStandings):
                self?.driverStanding = driverStandings.mrData.standingsTable.standingsLists[0].driverStandings
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        })
    }
}
