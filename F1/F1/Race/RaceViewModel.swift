//
//  RaceViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation

class RaceViewModel {

    // MARK: Variables
    private weak var delegate: ViewModelDelegate?
    private(set) var allRaces: [RaceInfo] = []
    private(set) var upcomingRaces: [RaceInfo]  = []
    private(set) var pastRaces: [RaceInfo]  = []
    private(set) var sortedRaceSession: [RaceSessionDetail] = []
    private var repository: RaceRepositoryType?
    private var race: RaceInfo?

    init(repository: RaceRepositoryType, delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: Computed
    var racesCount: Int {
        allRaces.count
    }

    var scheduleCount: Int {
        sortedRaceSession.count
    }

    var raceTitle: String {
        race?.raceName ?? ""
    }

    var circuitName: String {
        race?.circuit.circuitName ?? ""
    }

    var raceLocation: String {
        "\(race?.circuit.location.locality ?? "") | \(race?.circuit.location.country ?? "")"
    }

    // MARK: Functions
    func processRaceSessions() {
        addSession(date: race?.date, time: race?.time, type: .race)
        addSession(date: race?.qualifying.date, time: race?.qualifying.time, type: .qualifying)
        addSession(date: race?.thirdPractice?.date, time: race?.thirdPractice?.time, type: .practice3)

        if let sprint = race?.sprint {
            addSession(date: sprint.date, time: sprint.time, type: .sprint)
            addSession(date: race?.secondPractice.date, time: race?.secondPractice.time, type: .sprintQualifying)
        } else {
            addSession(date: race?.secondPractice.date, time: race?.secondPractice.time, type: .practice2)
        }

        addSession(date: race?.firstPractice.date, time: race?.firstPractice.time, type: .practice1)
    }

    func countRaces(upcoming: Bool) -> Int {
        if upcoming {
            return upcomingRaces.count
        } else {
            return pastRaces.count
        }
    }

    func race(atIndex: Int, upcoming: Bool) -> RaceInfo {
        if upcoming {
            return upcomingRaces[atIndex]
        } else {
            return pastRaces[atIndex]
        }
    }

    func imageName(circuitCode: String?) -> String {
        "\(circuitCode ?? "").png"
    }

    func raceSession(atIndex: Int) -> RaceSessionDetail {
        sortedRaceSession[atIndex]
    }

    func sessionDate(date: String) -> DateComponents {
        DateFormatter().customDateFormatter(date: date)
    }

    func sessionTime(time: String) -> String {
        let formattedTime = DateFormatter().customLocalTimeFormatter(time: time).prefix(5)
        return String(formattedTime)
    }

    func setRace(race: RaceInfo?) {
        self.race = race
    }

    func fetchRace() {
            repository?.fetchRaceResults { [weak self] result in
                switch result {
                case .success(let races):
                    self?.allRaces = races.race.raceTable.races
                    self?.sortRacesByRound()
                    self?.setRaces()
                    self?.delegate?.reloadView()
                case .failure(let error):
                    self?.delegate?.show(error: error.rawValue)
                }
            }
        }

    // MARK: Helper Functions
    private func addSession(date: String?, time: String?, type: SessionType) {
        if let date = date, let time = time {
            sortedRaceSession.append(RaceSessionDetail(date: date, time: time, type: type))
        }
    }

    private func sortRacesByRound() {
        allRaces.sort { race1, race2 in
            guard let round1 = Int(race1.round), let round2 = Int(race2.round) else {
                return false
            }
            return round1 < round2
        }
    }

    private func setRaces() {
        let nextRound = findNextRound()
        pastRaces = Array(allRaces[..<nextRound])
        upcomingRaces = Array(allRaces[nextRound...])
    }

    private func findNextRound() -> Int {
        let today = Date()
        return roundBinarySearch(date: today)
    }

    private func roundBinarySearch(date: Date) -> Int {
        var min = 0
        var max = allRaces.count - 1

        while min <= max {
            let mid = (min + max) / 2
            let raceDateComps = DateFormatter().customDateFormatter(date: allRaces[mid].date)
            let calendar = Calendar.current
            let raceDate = calendar.date(from: raceDateComps)

            if raceDate == date {
                return mid
            } else if raceDate! < date {
                min = mid + 1
            } else {
                max = mid - 1
            }
        }
        return min
    }
}
