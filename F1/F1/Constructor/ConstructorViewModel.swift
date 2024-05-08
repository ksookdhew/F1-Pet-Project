//
//  ConstructorViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

class ConstructorViewModel {

    // MARK: Variables
    private weak var delegate: ViewModelDelegate?
    private var repository: ConstructorRepositoryType?
    private var constructorResults: [Race]?
    private var constructor: ConstructorStanding?

    init(repository: ConstructorRepositoryType, delegate: ViewModelDelegate) {
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

    var constructorImageName: String {
        imageName(constructorId: constructor?.constructor.constructorID)
    }

    var constructorName: String? {
        constructor?.constructor.name
    }

    var constructorNationality: String? {
        constructor?.constructor.nationality
    }

    var currentPosition: String? {
        constructor?.position
    }

    var currentPoints: String? {
        constructor?.points
    }

    var currentWins: String? {
        constructor?.wins
    }

    var constructorDrivers: String {
        drivers
    }

    // MARK: Functions
    func setConstructor(constructor: ConstructorStanding?) {
        self.constructor = constructor
    }

    func result(atIndex: Int) -> Race? {
        constructorResults?.count ?? 0 > atIndex ? constructorResults?[atIndex] : nil
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
