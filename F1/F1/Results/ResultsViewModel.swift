//
//  ResultsViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation
class ResultsViewModel {
    private var repository: ResultsRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var results: Race?

    init(repository: ResultsRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }

    func fetchResults() {
        repository?.fetchRacingResults(completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.results = result.mrData.raceTable.races[1]
                print(self?.results ?? "No result")
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
                self?.delegate?.show(error: error.rawValue)
            }
        })
    }

    func fetchRoundResults(round: String) {
        repository?.fetchRoundResults(round: round, completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.results = result.mrData.raceTable.races[0]
                print(self?.results ?? "No result")
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
                self?.delegate?.show(error: error.rawValue)
            }
        })}
}
