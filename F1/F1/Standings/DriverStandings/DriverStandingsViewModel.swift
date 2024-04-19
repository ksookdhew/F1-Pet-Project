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
    var driversForConstructor: [String: [Driver?]] = [:]

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

        if let driverStanding = driverStanding {
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
            return driversForConstructor[constructorID] ?? []
        }

        func fetchDriverStandings() {
            repository?.fetchDriverStandingsResults { [weak self] result in
                switch result {
                case .success(let driverStandings):
                    self?.driverStanding = driverStandings.mrData.standingsTable.standingsLists[0].driverStandings
                    self?.delegate?.reloadView()
                case .failure(let error):
                    self?.delegate?.show(error: error.rawValue)
                }
            }
        }
    }
