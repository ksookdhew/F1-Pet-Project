//
//  DriverViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//


import Foundation

class DriverViewModel {
    
    private var repository: F1RepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var Driver: Driver?
    
    init(repository: F1RepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
//    var DriversCount: Int {
//        return Driver?.count ?? 0
//    }
//    
//    func Driver(atIndex: Int) -> DriverStanding? {
//        return DriverStanding?[atIndex] ?? nil
//    }
    
    func fetchDriver(driverName: String) {
        repository?.fetchDriverResults(driver:driverName,completion: { [weak self] result in
            switch result {
            case .success(let driver):
                self?.Driver = driver.mrData.driverTable.drivers[0]
                print(self?.Driver?.givenName ?? "No result")
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        })
    }
}
