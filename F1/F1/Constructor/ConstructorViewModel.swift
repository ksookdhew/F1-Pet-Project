//
//  ConstructorViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

class ConstructorViewModel {

    // MARK: Variables
    private var repository: ConstructorRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var constructorResults: [Race]?

    init(repository: ConstructorRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: Computed Variables
    var resultsCount: Int {
        constructorResults?.count ?? 0
    }

    var drivers: String {
        "\(constructorResults?.first?.results.first?.driver.code ?? "") | \(constructorResults?.first?.results.last?.driver.code ?? "")"
    }

    // MARK: Functions
    func result(atIndex: Int) -> Race? {
        if constructorResults?.count ?? 0 > atIndex, let result = constructorResults {
                return result[atIndex]
        }
        return nil
    }
    
    func imageName(constructorId: String?) -> String {
        "\(constructorId ?? "").png"
    }

    func fetchConstructor(constructorName: String?) {
        repository?.fetchConstructorResults(constructor: constructorName ?? "") { [weak self] result in
            switch result {
            case .success(let constructor):
                self?.constructorResults = constructor.results.raceTable.races
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
}
