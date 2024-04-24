//
//  RaceViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation

class RaceViewModel {

    // MARK: Variables
    private var repository: RaceRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private(set) var race: RaceInfo?
    private(set) var sortedRaceSession: [RaceSessionDetail] = []

    init(repository: RaceRepositoryType, delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: Computed
    var scheduleCount: Int {
        sortedRaceSession.count
    }

    var raceTitle: String {
        race?.circuit.location.country ?? ""
    }

    var raceName: String {
        race?.raceName ?? ""
    }

    var raceLocation: String {
        "\(race?.circuit.location.locality ?? "") | \(race?.circuit.location.country ?? "")"
    }

    // MARK: Functions
    func processRaceSessions() {
        if let raceDate = race?.date, let raceTime = race?.time {
            sortedRaceSession.append(RaceSessionDetail(date: raceDate, time: raceTime, type: .race))
        }

        if let qualifying = race?.qualifying {
            sortedRaceSession.append(RaceSessionDetail(date: qualifying.date, time: qualifying.time, type: .qualifying))
        }

        if let thirdPractice = race?.thirdPractice {
            sortedRaceSession.append(RaceSessionDetail(date: thirdPractice.date, time: thirdPractice.time, type: .practice3))
        }

        if let sprint = race?.sprint {
            sortedRaceSession.append(RaceSessionDetail(date: sprint.date, time: sprint.time, type: .sprint))
            sortedRaceSession.append(RaceSessionDetail(date: race?.secondPractice.date ?? "", time: race?.secondPractice.time ?? "", type: .sprintQualifying))
        } else if let secondPractice = race?.secondPractice {
            sortedRaceSession.append(RaceSessionDetail(date: secondPractice.date, time: secondPractice.time, type: .practice2))
        }

        if let firstPractice = race?.firstPractice {
            sortedRaceSession.append(RaceSessionDetail(date: firstPractice.date, time: firstPractice.time, type: .practice1))
        }

    }

    func raceSession(atIndex: Int) -> RaceSessionDetail {
        sortedRaceSession[atIndex]
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
                self?.race = race.race.raceTable.races.first
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
}
