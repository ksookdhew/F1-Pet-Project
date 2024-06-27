//
//  DriverStandingsViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew.
//

import Foundation

class DriverStandingsViewModel {

    // MARK: Variables
    private var repository: DriverStandingsRepositoryType?
    var driverStanding: [DriverStanding]?
    var isLoaded = false
    var driversForConstructor: [String: [Driver?]] = [:]

    init(repository: DriverStandingsRepositoryType) {
        self.repository = repository
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

    func fetchDriverStandings(completion: @escaping ([DriverStanding]?) -> Void) {
        repository?.fetchDriverStandingsResults { [weak self] result in
            switch result {
            case .success(let driverStandings):
                self?.driverStanding = driverStandings.driverStandings.standingsTable.standingsLists.first?.driverStandings
                self?.sortDriverStandings()
                self?.isLoaded = true
                completion(self?.driverStanding)
            case .failure:
                completion(nil)
            }
        }
    }

    func fetchDriverStandingsOffline(completion: @escaping ([DriverStanding]?) -> Void) {
        repository?.fetchDriverStandingsResultsOffline { [weak self] result in
            switch result {
            case .success(let driverStandings):
                self?.driverStanding = driverStandings.driverStandings.standingsTable.standingsLists.first?.driverStandings
                self?.sortDriverStandings()
                self?.isLoaded = true
                completion(self?.driverStanding)
            case .failure:
                completion(nil)
            }
        }
    }

    // MARK: Helper Function
    private func sortDriverStandings() {
        driverStanding = driverStanding?.sorted { Int($0.position) ?? 0 < Int($1.position) ?? 0 }
    }
}
