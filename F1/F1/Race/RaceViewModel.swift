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
    private(set) var race: RaceInfo?
    private(set) var sortedRaceSessions: [(key: String, value: RaceSessions)] = []

    init(repository: RaceRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }

    func raceSessionsCalculator() {
        var raceSessions: [String: RaceSessions] = [:]
        raceSessions["Race"] = RaceSessions(date: race?.date ?? "", time: race?.time ?? "")
        raceSessions["Practice 1"] = race?.firstPractice
        raceSessions["Qaulifying"] = race?.qualifying
        if let thirdPractice = race?.thirdPractice {
            raceSessions["Practice 2"] = race?.secondPractice
            raceSessions["Practice 3"] = thirdPractice
        } else if let sprint = race?.sprint {
            raceSessions["Sprint Qualifying"] = race?.secondPractice
            raceSessions["Sprint"] = sprint
        }
        let sortedRaceSessions = raceSessions.sorted { first, second in
            if first.value.date == second.value.date {
                return first.value.time < second.value.time
            } else {
                return first.value.date < second.value.date
            }
        }
        self.sortedRaceSessions = sortedRaceSessions
    }

    var scheduleCount: Int {
        return sortedRaceSessions.count
    }

    func raceSession(atIndex: Int) -> (key: String, value: RaceSessions) {
        return sortedRaceSessions[atIndex]
    }

    func sessionDate(date: String) -> DateComponents {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        let date = dateFormatter.date(from: date) ?? Date()
        let dateComps = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return dateComps
    }

    func sessionTime(time: String) -> String {
        let formattedTime = time.prefix(5)
        return String(formattedTime)
    }

    func fetchRace() {
        repository?.fetchRaceResults { [weak self] result in
            switch result {
            case .success(let race):
                self?.race = race.mrData.raceTable.races[4]
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
}
