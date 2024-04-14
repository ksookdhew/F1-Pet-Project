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
        if let resTime = driverResults?[index].results[0].time {
            return resTime.time
        } else {
            let stat = driverResults?[index].results[0].status
            if let statFinal = stat {
                if !statFinal.contains("Lap") {
                    return "DNF"
                } else {
                    return statFinal
                }
            } else {
                return "No Time"
            }
        }

    }

    func fetchDriver(driverName: String) {
        repository?.fetchDriverResults(driver: driverName, completion: { [weak self] result in
            switch result {
            case .success(let driver):
                self?.driverResults = driver.mrData.raceTable.races
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
                self?.delegate?.show(error: error.rawValue)
            }
        })
    }
}
