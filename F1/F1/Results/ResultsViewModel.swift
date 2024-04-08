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
    private var race: Race?
    private var allResults: [Race]?
    private var raceResult: [RacingResult]?

    init(repository: ResultsRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }

    var allResultsCount: Int {
        return allResults?.count ?? 0
    }

    func allResult(atIndex: Int) -> Race? {
        return allResults?[atIndex] ?? nil
    }
    
    var raceResultsCount: Int {
        return raceResult?.count ?? 0
    }
 
    func raceResult(atIndex: Int) -> RacingResult? {
        return raceResult?[atIndex] ?? nil
    }
    
    func fetchResults() {
        repository?.fetchRacingResults(completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.allResults = result.mrData.raceTable.races
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
                self?.race = result.mrData.raceTable.races[0]
                self?.raceResult = self?.race?.results
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
                self?.delegate?.show(error: error.rawValue)
            }
        })}
}
