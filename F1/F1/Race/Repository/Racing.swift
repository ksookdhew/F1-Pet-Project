//
//  RaceModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

// MARK: - Racing
struct Racing: Codable {
    let race: RaceDescriptor

    enum CodingKeys: String, CodingKey {
        case race = "MRData"
    }
}

// MARK: - RaceDescriptor
struct RaceDescriptor: Codable {
    let series, url, limit, offset, total: String
    let raceTable: RaceSheduleTable

    enum CodingKeys: String, CodingKey {
        case series, url, limit, offset, total
        case raceTable = "RaceTable"
    }
}

// MARK: - RaceTable
struct RaceSheduleTable: Codable {
    let season: String
    let races: [RaceInfo]

    enum CodingKeys: String, CodingKey {
        case season
        case races = "Races"
    }
}

// MARK: - Race
struct RaceInfo: Codable {
    let season, round, url, raceName: String
    let circuit: Circuit
    let date, time: String
    let firstPractice, secondPractice: RaceSession
    let thirdPractice: RaceSession?
    let qualifying: RaceSession
    let sprint: RaceSession?

    enum CodingKeys: String, CodingKey {
        case season, round, url, raceName
        case circuit = "Circuit"
        case date, time
        case firstPractice = "FirstPractice"
        case secondPractice = "SecondPractice"
        case thirdPractice = "ThirdPractice"
        case qualifying = "Qualifying"
        case sprint = "Sprint"
    }
    init(season: String, round: String, url: String, raceName: String, circuit: Circuit, 
         date: String, time: String, firstPractice: RaceSession, secondPractice: RaceSession, thirdPractice: RaceSession?, qualifying: RaceSession, sprint: RaceSession?) {
        self.season = season
        self.round = round
        self.url = url
        self.raceName = raceName
        self.circuit = circuit
        self.date = date
        self.time = time
        self.firstPractice = firstPractice
        self.secondPractice = secondPractice
        self.thirdPractice = thirdPractice
        self.qualifying = qualifying
        self.sprint = sprint
    }

    init(from coreDataRaceInfo: CoreDataRaceInfo) {
            self.season = coreDataRaceInfo.season ?? ""
            self.round = coreDataRaceInfo.round ?? ""
            self.url = coreDataRaceInfo.url ?? ""
            self.raceName = coreDataRaceInfo.raceName ?? ""
            self.date = coreDataRaceInfo.date ?? ""
            self.time = coreDataRaceInfo.time ?? ""
            self.circuit = Circuit(from: coreDataRaceInfo.circuit!)
            self.firstPractice = RaceSession(from: coreDataRaceInfo.firstPractice!)
            self.secondPractice = RaceSession(from: coreDataRaceInfo.secondPractice!)
            self.thirdPractice = coreDataRaceInfo.thirdPractice != nil ? RaceSession(from: coreDataRaceInfo.thirdPractice!) : nil
            self.qualifying = RaceSession(from: coreDataRaceInfo.qualifying!)
            self.sprint = coreDataRaceInfo.sprint != nil ? RaceSession(from: coreDataRaceInfo.sprint!) : nil
        }
}

// MARK: - RaceSession
struct RaceSession: Codable {
    let date, time: String

    init(date: String, time: String) {
          self.date = date
          self.time = time
      }

    init(from coreDataRaceSession: CoreDataRaceSession) {
            self.date = coreDataRaceSession.date ?? ""
            self.time = coreDataRaceSession.time ?? ""
        }
}

// MARK: - SessionType
enum SessionType: String {
    case race = "Race"
    case practice1 = "Practice 1"
    case qualifying = "Qualifying"
    case practice2 = "Practice 2"
    case practice3 = "Practice 3"
    case sprintQualifying = "Sprint Qualifying"
    case sprint = "Sprint"
}

// MARK: - RaceSessionDetail
struct RaceSessionDetail {
    let date, time: String
    let type: SessionType
}
