//
//  DriverStandingsViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew.
//

import Foundation

class DriverStandingsViewModel {

    // MARK: Variables
    private weak var delegate: ViewModelDelegate?
    private var repository: DriverStandingsRepositoryType?
    private var driverStanding: [DriverStanding]?
    var isLoaded = false
    var driversForConstructor: [String: [Driver?]] = [:]

    init(repository: DriverStandingsRepositoryType, delegate: ViewModelDelegate) {
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
        guard let driverStanding = driverStanding else { return }

        for driver in driverStanding {
            guard let constructorID = driver.constructors.first?.constructorID else { continue }

            var drivers = driversForConstructor[constructorID] ?? []
            drivers.append(driver.driver)
            driversForConstructor[constructorID] = drivers
        }
    }

    func getConstructorDrivers(constructorID: String) -> [Driver?]? {
        driversForConstructor[constructorID] ?? []
    }

    func fetchDriverStandings() {
        isLoaded = true
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
