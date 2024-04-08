//
//  RaceResultViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import Foundation
class RaceResultsViewModel {
    private var repository: ResultsRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var race: Race?
    private var raceResult: [RacingResult]?

    init(repository: ResultsRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }

    var raceResultsCount: Int {
        return raceResult?.count ?? 0
    }

    var raceName: String {
        print(race?.raceName ?? "Race Name")
        return race?.raceName ?? "Race Name"
        
    }

    func raceResult(atIndex: Int) -> RacingResult? {
        return raceResult?[atIndex] ?? nil
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
