//
//  ResultsViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation
class ResultsViewModel {

    // MARK: Variables
    private var repository: ResultsRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var allResults: [Race]?
    private var race: Race?
    private var raceResult: [RacingResult]?

    init(repository: ResultsRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: Computed
    var allResultsCount: Int {
        return allResults?.count ?? 0
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        let date = dateFormatter.date(from: result?.date ?? "2024-00-00") ?? Date()
        let dateComps = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return dateComps
    }

    func setRaceResult(raceRes: Race?) {
        race = raceRes
        raceResult = race?.results
    }

    func raceResult(atIndex: Int) -> RacingResult? {
        raceResult?[atIndex] ?? nil
    }

    func laptime(index: Int) -> String {
        if let resTime = raceResult?[index].time {
            return resTime.time
        } else {
            let stat = raceResult?[index].status
            if let statFinal = stat {
                if !statFinal.contains("Lap") {
                    return "DNF"
                } else {
                    return statFinal
                }
            } else {
                return "No Time"
            }
        }
    }

    func fetchResults() {
        repository?.fetchRacingResults { [weak self] result in
            switch result {
            case .success(let result):
                // TODO: Change mrData
                self?.allResults = result.mrData.raceTable.races
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
}
