//
//  ConstructorViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

class ConstructorViewModel {
    
    private var repository: ConstructorRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var constructorResults: [Race]?

    init(repository: ConstructorRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    var resultsCount: Int {
        return constructorResults?.count ?? 0
    }

    func result(atIndex: Int) -> Race? {
        if constructorResults?.count ?? 0 > atIndex {
            return constructorResults?[atIndex] ?? nil }
        return nil
    }

    func getDrivers() -> String {
        return "\(constructorResults?[0].results[0].driver.code ?? "") | \(constructorResults?[0].results[1].driver.code ?? "")"
    }
    
    func fetchConstructor(constructorName: String) {
        repository?.fetchConstructorResults(constructor:constructorName,completion: { [weak self] result in
            switch result {
            case .success(let constructor):
                self?.constructorResults = constructor.mrData.raceTable.races
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
                self?.delegate?.show(error: error.rawValue)
            }
        })
    }
}
