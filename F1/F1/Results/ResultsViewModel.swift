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
    private var results: Results?
    
    init(repository: ResultsRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    func fetchResults(roundNo: String) {
        repository?.fetchResultsResults(round:roundNo,completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.results = result.mrData.raceTable.races[0].results[0]
                print(self?.results?.driver.familyName ?? "No result")
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
                self?.delegate?.show(error: error.rawValue)
            }
        })
    }
}
