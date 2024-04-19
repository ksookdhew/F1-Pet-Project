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

    var drivers: String {
        return "\(constructorResults?.first?.results.first?.driver.code ?? "") |\(constructorResults?.first?.results.last?.driver.code ?? "")"
    }

    func imageName(constructorId: String?) -> String {
        return "\(constructorId ?? "").png"
    }

    func fetchConstructor(constructorName: String?) {
        repository?.fetchConstructorResults(constructor: constructorName ?? "") { [weak self] result in
            switch result {
            case .success(let constructor):
                self?.constructorResults = constructor.mrData.raceTable.races
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
}
