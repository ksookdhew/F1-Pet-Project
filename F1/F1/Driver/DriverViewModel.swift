//
//  DriverViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

class DriverViewModel {

    private var repository: DriverRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var driverResults: [Race]?

    init(repository: DriverRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    var resultsCount: Int {
        return driverResults?.count ?? 0
    }

    func result(atIndex: Int) -> Race? {
        return driverResults?[atIndex] ?? nil
    }

    func laptime(index: Int) -> String {
        if let resultTime = driverResults?[index].results.first?.time {
            return resultTime.time
        } else {
            let finishingStatus = driverResults?[index].results.first?.status
            if let status = finishingStatus {
                if !status.contains("Lap") {
                    return "DNF"
                } else {
                    return status
                }
            } else {
                return "No Time"
            }
        }
    }

    func imageName(driverCode: String) -> String {
        return "\(driverCode).png"
    }

    func fetchDriver(driverName: String) {
        repository?.fetchDriverResults(driver: driverName) { [weak self] result in
            switch result {
            case .success(let driver):
                self?.driverResults = driver.mrData.raceTable.races
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
}
