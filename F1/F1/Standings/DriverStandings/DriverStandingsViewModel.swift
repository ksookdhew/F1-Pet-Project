//
//  DriverStandingsViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew.
//

import Foundation

// MARK: ViewModelDelegate protocol
protocol ViewModelDelegate: AnyObject {
    func reloadView()
    func show(error: String)
}

class DriverStandingsViewModel {

    // MARK: Variables
    private var repository: DriverStandingsRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var driverStanding: [DriverStanding]?
    var driversForConstructor: [String: [Driver?]] = [:]

    init(repository: DriverStandingsRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: Computed Variables
    var driversCount: Int {
        driverStanding?.count ?? 0
    }

    // MARK: Functions
    func driver(atIndex: Int) -> DriverStanding? {
        driverStanding?[atIndex] ?? nil
    }

    func setConstructors() {
        if let driverStanding {
            for driver in driverStanding {
                if let constructor = driver.constructors.first?.constructorID {
                    if var drivers = driversForConstructor[constructor] {
                        drivers.append(driver.driver)
                        driversForConstructor[constructor] = drivers
                    } else {
                        driversForConstructor[constructor] = [driver.driver]
                    }
                }
            }
        }
    }

    func getConstructorDrivers(constructorID: String) -> [Driver?]? {
        driversForConstructor[constructorID] ?? []
    }

    func fetchDriverStandings() {
        repository?.fetchDriverStandingsResults { [weak self] result in
            switch result {
            case .success(let driverStandings):
                self?.driverStanding = driverStandings.driverStandings.standingsTable.standingsLists.first?.driverStandings
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
}
