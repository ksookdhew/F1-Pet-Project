//
//  ResultsViewModelTests.swift
//  F1Tests
//
//  Created by Kaitlyn Sookdhew on 2024/05/04.
//
class MockResultsRepository: ResultsRepositoryType {
    var fetchResultsShouldFail: Bool = false
    var mockResultsModel: RacingResults?

    func fetchRoundResults(round: String, completion: @escaping (ResultsResults)) {
        if fetchResultsShouldFail {
            completion(.failure(.serverError))
        } else {
            completion(.success(mockResultsModel ?? RacingResults(results: ResultsResponse(series: "F1", url: "", limit: "10",
                                                                                     offset: "0", total: "1", raceTable: RaceTable(season: "2024", races: [])))))
        }
    }

    func fetchRacingResults(completion: @escaping (ResultsResults)) {
        if fetchResultsShouldFail {
            completion(.failure(.serverError))
        } else {
            completion(.success(mockResultsModel ?? RacingResults(results: ResultsResponse(series: "F1", url: "", limit: "10",
                                                                                     offset: "0", total: "1", raceTable: RaceTable(season: "2024", races: [])))))
        }
    }
}

import XCTest
@testable import F1

class ResultsViewModelTests: XCTestCase {
    var viewModel: ResultsViewModel!
    var mockRepository: MockResultsRepository!
    var mockDelegate: MockViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockRepository = MockResultsRepository()
        mockDelegate = MockViewModelDelegate()
        viewModel = ResultsViewModel(repository: mockRepository, delegate: mockDelegate)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testFetchResults_Success() {
        setupMockResults()
        viewModel.fetchResults()

        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertEqual(viewModel.allResultsCount, 1)
        XCTAssertNotNil(viewModel.allResult(atIndex: 0))
    }

    func testFetchResults_Failure() {
        mockRepository.fetchResultsShouldFail = true
        viewModel.fetchResults()

        XCTAssertTrue(mockDelegate.showErrorCalled)
    }

    func testRaceResult_AtIndex() {
        let race = setupRace()
        viewModel.setRaceResult(raceResult: race)

        XCTAssertEqual(viewModel.raceResultsCount, 1)
        XCTAssertEqual(viewModel.raceResult(atIndex: 0)?.position, "1")
        XCTAssertEqual(viewModel.raceName, "Grand Prix")
    }

    func testAllResultDate() {
        let race = setupRace()
        verifyDateComponents(for: race, year: 2024)
        verifyDateComponents(for: nil, year: 2024)
    }

    func testLaptime_WithTime() {
        let race = setupRace()
        viewModel.setRaceResult(raceResult: race)

        let lapTime = viewModel.laptime(index: 0)
        XCTAssertEqual(lapTime, "1:30:45")
    }

    func testLaptime_WithStatusButNoLap() {
        let race = setupRace(status: "Retired", time: nil)
        viewModel.setRaceResult(raceResult: race)

        let lapTime = viewModel.laptime(index: 0)
        XCTAssertEqual(lapTime, "DNF")
    }

    func testLaptime_WithStatusContainingLap() {
        let race = setupRace(status: "+1 Lap", time: nil)
        viewModel.setRaceResult(raceResult: race)

        let lapTime = viewModel.laptime(index: 0)
        XCTAssertEqual(lapTime, "+1 Lap")
    }

    func testLaptime_NoTimeNoStatus() {
        viewModel.setRaceResult(raceResult: nil)

        let lapTime = viewModel.laptime(index: 0)
        XCTAssertEqual(lapTime, "No Time")
    }

    func testEmptyRaceResult() {
        viewModel.setRaceResult(raceResult: nil)
        XCTAssertEqual(viewModel.raceResultsCount, 0)
        XCTAssertEqual(viewModel.raceName, "Race Name")
        XCTAssertNil(viewModel.raceResult(atIndex: 0))
    }

    func testEmptyAllResult() {
        XCTAssertNil(viewModel.allResult(atIndex: 0))
    }

    // MARK: - Helper Functions
    private func setupMockResults() {
        mockRepository.mockResultsModel = RacingResults(
            results: ResultsResponse(
                series: "F1", url: "http://example.com", limit: "10",
                offset: "0", total: "1",
                raceTable: RaceTable(season: "2024", races: [setupRace()])
            )
        )
    }

    private func setupRace(status: String = "Finished", time: ResultTime? = ResultTime(millis: "5453922", time: "1:30:45")) -> Race {
        return Race(
            season: "2024", round: "1", url: "", raceName: "Grand Prix",
            circuit: Circuit(circuitID: "monza", circuitName: "Monza", url: "", location: Location(latitude: "", longitude: "", locality: "", country: "")),
            date: "2024-05-01", time: "14:00",
            results: [
                RaceResult(number: "1", position: "1", positionText: "P1", points: "25",
                             driver: Driver(driverID: "driver1", permanentNumber: "33", code: "VER", url: "", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", 
                                            nationality: "Dutch"),
                             constructor: Constructor(constructorID: "redbull", url: "", name: "Red Bull", nationality: "Austrian"),
                             grid: "2", laps: "58", status: status, time: time, fastestLap: nil)
            ]
        )
    }

    private func verifyDateComponents(for race: Race?, year expectedYear: Int) {
        let result = viewModel.allResultDate(result: race)
        XCTAssertEqual(result.year, expectedYear)
    }
}
