//
//  DriverViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

class DriverViewModel {

    // MARK: Variables
    private weak var delegate: ViewModelDelegate?
    private var repository: DriverRepositoryType?
    private var driverResults: [Race]?
    private var driver: DriverStanding?

    init(repository: DriverRepositoryType, delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: Computed Variables
    var resultsCount: Int {
        driverResults?.count ?? 0
    }

    var driverImageName: String {
        imageName(driverCode: driver?.driver.code)
    }

    var driverGivenName: String? {
        driver?.driver.givenName
    }

    var driverFamilyName: String? {
        driver?.driver.familyName
    }

    var driverConstructorInfo: String {
        "\(driver?.driver.permanentNumber ?? "") | \(driver?.constructors.first?.name ?? "")"
    }

    var driverNationality: String? {
        driver?.driver.nationality
    }

    var currentPosition: String? {
        driver?.position
    }

    var currentPoints: String? {
        driver?.points
    }

    var currentWins: String? {
        driver?.wins
    }

    // MARK: Functions
    func setDriver(driver: DriverStanding?) {
        self.driver = driver
    }

    func result(atIndex: Int) -> Race? {
        driverResults?[atIndex] ?? nil
    }

    func laptime(index: Int) -> String {
        guard let resultTime = driverResults?[index].results.first?.time else {
            if let status = driverResults?[index].results.first?.status {
                if !status.contains("Lap") {
                    return "DNF"
                } else {
                    return status
                }
            } else {
                return "No Time"
            }
        }
        return resultTime.time
    }

    func imageName(driverCode: String?) -> String {
        "\(driverCode ?? "").png"
    }

    func fetchDriver(driverName: String?) {
        repository?.fetchDriverResults(driver: driverName ?? "") { [weak self] result in
            switch result {
            case .success(let driver):
                self?.driverResults = driver.results.raceTable.races.reversed()
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
}
