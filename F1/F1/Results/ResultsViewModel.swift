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
    private var allResults: [Race]?

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

    func allResultDate(atIndex: Int) -> DateComponents {
        var race = allResults?[atIndex] ?? nil
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        let date = dateFormatter.date(from: race?.date ?? "2024-00-00") ?? Date()
        let dateComps = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return dateComps
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
}
