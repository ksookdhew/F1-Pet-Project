//
//  ResultsViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation
class ResultsViewModel {

    // MARK: Variables
    private weak var delegate: ViewModelDelegate?
    private var repository: ResultsRepositoryType?
    private var allResults: [Race]?
    private var raceResult: [RaceResult]?
    private var race: Race?

    init(repository: ResultsRepositoryType, delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: Computed
    var allResultsCount: Int {
        allResults?.count ?? 0
    }

    var raceResultsCount: Int {
        raceResult?.count ?? 0
    }

    var raceName: String {
        race?.raceName ?? "Race Name"
    }

    // MARK: Functions
    func allResult(atIndex: Int) -> Race? {
        allResults?[atIndex] ?? nil
    }

    func allResultDate(result: Race?) -> DateComponents {
        DateFormatter().customDateFormatter(date: result?.date ?? "2024-00-00")
    }

    func setRaceResult(raceResult: Race?) {
        race = raceResult
        self.raceResult = race?.results
    }

    func raceResult(atIndex: Int) -> RaceResult? {
        raceResult?[atIndex] ?? nil
    }

    func laptime(index: Int) -> String {
        guard let resultTime = raceResult?[index].time else {
            if let status = raceResult?[index].status {
                if !status.contains("Lap") {
                    return "DNF"
                } else {
                    return status
                }
            } else {
                return "No Time"
            }
        }
        return resultTime.time
    }

    func fetchResults() {
        repository?.fetchRacingResults { [weak self] result in
            switch result {
            case .success(let result):
                self?.allResults = result.results.raceTable.races
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
}
