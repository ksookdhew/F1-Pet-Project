//
//  RacingTests.swift
//  F1Tests
//
//  Created by Kaitlyn Sookdhew on 2024/04/29.
//

import XCTest
@testable import F1

class MockRaceRepository: RaceRepositoryType {
    var shouldReturnError: Bool = false
    var mockRaces: Racing?

    func fetchRaceResults(completion: @escaping (Result<Racing, APIError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.serverError))
        } else {
            completion(.success(mockRaces ?? Racing(race: RaceDescriptor(series: "", url: "", limit: "", offset: "", total: "", raceTable: RaceSheduleTable(season: "", races: [])))))
        }
    }
}

class MockViewModelDelegate: ViewModelDelegate {
    var reloadViewCalled = false
    var showErrorCalled = false
    var errorMessage: String?

    func reloadView() {
        reloadViewCalled = true
    }

    func show(error: String) {
        showErrorCalled = true
        errorMessage = error
    }
}

final class RaceViewModelTests: XCTestCase {
    var viewModel: RaceViewModel!
    var mockRepository: MockRaceRepository!
    var mockDelegate: MockViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockRepository = MockRaceRepository()
        mockDelegate = MockViewModelDelegate()
        viewModel = RaceViewModel(repository: mockRepository, delegate: mockDelegate)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testInitialization_DefaultValues() {
        XCTAssertTrue(viewModel.allRaces.isEmpty)
        XCTAssertEqual(viewModel.sortedRaceSession.count, 0)
    }

    func testFetchRace_Success() {
        mockRepository.mockRaces = Racing(race: RaceDescriptor(series: "F1", url: "http://example.com", limit: "10", offset: "0", total: "1", raceTable: RaceSheduleTable(season: "2024", races: [
            RaceInfo(season: "2024", round: "1", url: "http://example.com/race1", raceName: "Grand Prix 2024",
                     circuit: Circuit(circuitID: "001", url: "http://example.com/circuit",
                     circuitName: "Silverstone", location: Location(latitude: "52.0786",
                     longitude: "-1.01694", locality: "Silverstone", country: "UK")),
                     date: "2024-07-12", time: "14:00:00",
                     firstPractice: RaceSession(date: "2024-07-10", time: "12:00:00"),
                     secondPractice: RaceSession(date: "2024-07-11", time: "12:00:00"),
                     thirdPractice: nil,
                     qualifying: RaceSession(date: "2024-07-11", time: "15:00:00"), sprint: nil)])))

        viewModel.fetchRace()
        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertEqual(viewModel.racesCount, 1)
        XCTAssertEqual(viewModel.allRaces.first?.raceName, "Grand Prix 2024")
    }

    func testFetchRace_Failure() {
        mockRepository.shouldReturnError = true
        viewModel.fetchRace()

        XCTAssertTrue(mockDelegate.showErrorCalled)
        XCTAssertNotNil(mockDelegate.errorMessage)
    }

    func testProcessRaceSessionsSprint() {
        let repository = MockRaceRepository()
        let delegate = MockViewModelDelegate()
        let viewModel = RaceViewModel(repository: repository, delegate: delegate)

        let raceInfo = RaceInfo(
            season: "2024",
            round: "1",
            url: "http://example.com/race1",
            raceName: "Monaco Grand Prix",
            circuit: Circuit(
                circuitID: "monaco",
                url: "http://example.com/circuit/monaco",
                circuitName: "Circuit de Monaco",
                location: Location(
                    latitude: "43.7347",
                    longitude: "7.42056",
                    locality: "Monte Carlo",
                    country: "Monaco"
                )
            ),
            date: "2024-05-26",
            time: "14:00",
            firstPractice: RaceSession(date: "2024-05-23", time: "10:00"),
            secondPractice: RaceSession(date: "2024-05-24", time: "10:00"),
            thirdPractice: nil,
            qualifying: RaceSession(date: "2024-05-25", time: "15:00"),
            sprint: RaceSession(date: "2024-05-25", time: "11:00")
        )

        viewModel.setRace(race: raceInfo)
        viewModel.processRaceSessions()

        XCTAssertEqual(viewModel.scheduleCount, 5)
        XCTAssertTrue(viewModel.sortedRaceSession.contains { $0.type == .race }, "Should contain the race session.")
        XCTAssertTrue(viewModel.sortedRaceSession.contains { $0.type == .practice1 }, "Should contain Practice 1 session.")
        XCTAssertTrue(viewModel.sortedRaceSession.contains { $0.type == .sprintQualifying }, "Should contain Sprint Qualifying.")
        XCTAssertTrue(viewModel.sortedRaceSession.contains { $0.type == .sprint }, "Should contain Practice Sprint session.")
        XCTAssertTrue(viewModel.sortedRaceSession.contains { $0.type == .qualifying }, "Should contain the qualifying session.")

    }

    func testProcessRaceSessionsNoSprint() {
        let repository = MockRaceRepository()
        let delegate = MockViewModelDelegate()
        let viewModel = RaceViewModel(repository: repository, delegate: delegate)

        let raceInfo = RaceInfo(
            season: "2024",
            round: "1",
            url: "http://example.com/race1",
            raceName: "Monaco Grand Prix",
            circuit: Circuit(
                circuitID: "monaco",
                url: "http://example.com/circuit/monaco",
                circuitName: "Circuit de Monaco",
                location: Location(
                    latitude: "43.7347",
                    longitude: "7.42056",
                    locality: "Monte Carlo",
                    country: "Monaco"
                )
            ),
            date: "2024-05-26",
            time: "14:00",
            firstPractice: RaceSession(date: "2024-05-23", time: "10:00"),
            secondPractice: RaceSession(date: "2024-05-24", time: "10:00"),
            thirdPractice: RaceSession(date: "2024-05-25", time: "11:00"),
            qualifying: RaceSession(date: "2024-05-25", time: "15:00"),
            sprint: nil
        )

        viewModel.setRace(race: raceInfo)
        viewModel.processRaceSessions()

        XCTAssertEqual(viewModel.scheduleCount, 5)
        XCTAssertTrue(viewModel.sortedRaceSession.contains { $0.type == .race })
        XCTAssertTrue(viewModel.sortedRaceSession.contains { $0.type == .practice1 })
        XCTAssertTrue(viewModel.sortedRaceSession.contains { $0.type == .practice2 })
        XCTAssertTrue(viewModel.sortedRaceSession.contains { $0.type == .practice3 })
        XCTAssertTrue(viewModel.sortedRaceSession.contains { $0.type == .qualifying })

        let session = viewModel.raceSession(atIndex: 1)
        XCTAssertEqual(session.type, .qualifying)
    }

    func testComputedProperties() {
        let repository = MockRaceRepository()
        let delegate = MockViewModelDelegate()
        let viewModel = RaceViewModel(repository: repository, delegate: delegate)

        let circuit = Circuit(
            circuitID: "silverstone",
            url: "http://example.com/circuit/silverstone",
            circuitName: "Silverstone Circuit",
            location: Location(
                latitude: "52.0786",
                longitude: "-1.01694",
                locality: "Silverstone",
                country: "UK"
            )
        )
        let raceInfo = RaceInfo(
            season: "2024",
            round: "10",
            url: "http://example.com/race/british",
            raceName: "British Grand Prix",
            circuit: circuit,
            date: "2024-07-14",
            time: "14:00",
            firstPractice: RaceSession(date: "2024-07-12", time: "10:00"),
            secondPractice: RaceSession(date: "2024-07-12", time: "15:00"),
            thirdPractice: RaceSession(date: "2024-07-13", time: "10:00"),
            qualifying: RaceSession(date: "2024-07-13", time: "14:00"),
            sprint: nil
        )

        viewModel.setRace(race: raceInfo)

        XCTAssertEqual(viewModel.raceTitle, "British Grand Prix", "raceTitle should return the race name.")
        XCTAssertEqual(viewModel.circuitName, "Silverstone Circuit", "circuitName should return the circuit name.")
        XCTAssertEqual(viewModel.raceLocation, "Silverstone | UK", "raceLocation should return formatted location.")
    }

    func testEmptyComputedProperties() {
        let raceInfo: RaceInfo? = nil

        viewModel.setRace(race: raceInfo)

        XCTAssertEqual(viewModel.raceTitle, "")
        XCTAssertEqual(viewModel.circuitName, "")
        XCTAssertEqual(viewModel.raceLocation, " | ")
    }

    func testFunctions() {
        mockRepository.mockRaces = Racing(race: RaceDescriptor(series: "F1", url: "http://example.com", limit: "10", offset: "0", total: "1", raceTable: RaceSheduleTable(season: "2024", races: [
            RaceInfo(season: "2024", round: "1", url: "http://example.com/race1", raceName: "Grand Prix 2024",
                     circuit: Circuit(circuitID: "001", url: "http://example.com/circuit",
                     circuitName: "Silverstone", location: Location(latitude: "52.0786",
                     longitude: "-1.01694", locality: "Silverstone", country: "UK")),
                     date: "2024-07-12", time: "14:00:00",
                     firstPractice: RaceSession(date: "2024-07-10", time: "12:00:00"),
                    secondPractice: RaceSession(date: "2024-07-11", time: "12:00:00"),
                     thirdPractice: nil,
                     qualifying: RaceSession(date: "2024-07-11", time: "15:00:00"), sprint: nil),
            RaceInfo(season: "2024", round: "2", url: "", raceName: "Italian Grand Prix", circuit: 
            Circuit(circuitID: "monza", url: "", circuitName: "", location:
            Location(latitude: "", longitude: "", locality: "Monza", country: "Italy")), date: "", time: "",
            firstPractice: RaceSession(date: "", time: ""),
            secondPractice: RaceSession(date: "", time: ""),
            thirdPractice: nil, qualifying: RaceSession(date: "", time: ""), sprint: nil)])))

        viewModel.fetchRace()
        let race = viewModel.race(atIndex: 1)
        XCTAssertEqual(race.raceName, "Italian Grand Prix")

        XCTAssertEqual(viewModel.imageName(circuitCode: "monza"), "monza.png")
        XCTAssertEqual(viewModel.imageName(circuitCode: nil), ".png")

        let dateComponents = viewModel.sessionDate(date: "2024-05-01")
        XCTAssertEqual(dateComponents.year, 2024)
        XCTAssertEqual(dateComponents.month, 5)
        XCTAssertEqual(dateComponents.day, 1)

        let invalidDateString = "invalid-date"
        let currentDate = Date()
        let calendar = Calendar.current
        let expectedComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        let invalidDateComponents = viewModel.sessionDate(date: invalidDateString)

        XCTAssertEqual(invalidDateComponents.year, expectedComponents.year)
        XCTAssertEqual(invalidDateComponents.month, expectedComponents.month)
        XCTAssertEqual(invalidDateComponents.day, expectedComponents.day)

        XCTAssertEqual(viewModel.sessionTime(time: "14:00:00"), "14:00")
    }
}
