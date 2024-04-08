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
    private var driver: Driver?
    
    init(repository: DriverRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    func fetchDriver(driverName: String) {
        repository?.fetchDriverResults(driver: driverName, completion: { [weak self] result in
            switch result {
            case .success(let driver):
                self?.driver = driver.mrData.driverTable.drivers[0]
                print(self?.driver?.givenName ?? "No result")
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        })
    }
}
