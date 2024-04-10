//
//  RaceViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation

class RaceViewModel {
    
    private var repository: RaceRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var race: RaceShedule?
    
    init(repository: RaceRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    func fetchRace(roundNo: String) {
        repository?.fetchRaceResults(round:roundNo,completion: { [weak self] result in
            switch result {
            case .success(let race):
                self?.race = race.mrData.raceTable.races[0]
                print(self?.race ?? "No result")
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
                self?.delegate?.show(error: error.rawValue)
            }
        })
    }
}
