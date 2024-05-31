//
//  ConstructorViewModelTests.swift
//  F1Tests
//
//  Created by Kaitlyn Sookdhew on 2024/05/06.
//

import XCTest
@testable import F1

class MockConstructorRepository: ConstructorRepositoryType {
    var shouldReturnError = false
    var mockResults: RacingResults?

    func fetchConstructorResults(constructor: String, completion: @escaping ConstructorResults) {
        if shouldReturnError {
            completion(.failure(.serverError))
        } else {
            completion(.success(mockResults ?? RacingResults(results: ResultsResponse(series: "F1", url: "",
                        limit: "10", offset: "0", total: "1", raceTable: RaceTable(season: "2024", races: [])))))
        }
    }
}

final class ConstructorViewModelTests: XCTestCase {

    var viewModel: ConstructorViewModel!
    var mockRepository: MockConstructorRepository!
    var mockDelegate: MockViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockRepository = MockConstructorRepository()
        mockDelegate = MockViewModelDelegate()
        viewModel = ConstructorViewModel(repository: mockRepository, delegate: mockDelegate)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testFetchDriverResults_Success() {
        let races = [
            Race(season: "2024", round: "1", url: "", raceName: "Italian GP",
                 circuit: Circuit(circuitID: "monza", circuitName: "Monza", url: "",
                 location: Location(latitude: "", longitude: "", locality: "", country: "Italy")),
                 date: "2024-09-02", time: "15:00", results: [])
        ]

        mockRepository.mockResults = RacingResults(results: ResultsResponse(series: "F1", url: "", limit: "10", offset: "0", total: "1", raceTable: RaceTable(season: "2024", races: races)))

        viewModel.fetchConstructor(constructorName: "mercedes")

        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertEqual(viewModel.resultsCount, 1)
    }

    func testFetchDriverResults_nil() {
        let races = [
            Race(season: "2024", round: "1", url: "", raceName: "Italian GP",
                 circuit: Circuit(circuitID: "monza", circuitName: "Monza", url: "",
                 location: Location(latitude: "", longitude: "", locality: "", country: "Italy")),
                 date: "2024-09-02", time: "15:00", results: [])
        ]

        mockRepository.mockResults = RacingResults(results: ResultsResponse(series: "F1", url: "", limit: "10", offset: "0", total: "1", raceTable: RaceTable(season: "2024", races: races)))

        viewModel.fetchConstructor(constructorName: nil)

        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertEqual(viewModel.resultsCount, 1)
    }

    func testFetchDriverResults_Failure() {
        mockRepository.shouldReturnError = true

        viewModel.fetchConstructor(constructorName: "Alpha tauri")

        XCTAssertNotNil(mockDelegate.showErrorCalled)
        XCTAssertEqual(viewModel.resultsCount, 0)
    }

    func testImageName() {
        let validImage = viewModel.imageName(constructorId: "mercedes")
        XCTAssertEqual(validImage, "mercedes.png")

        let invalidImage = viewModel.imageName(constructorId: nil)
        XCTAssertEqual(invalidImage, ".png")
    }

    func testDrivers() {
        let resultTime = ResultTime(millis: "123456", time: "1:25.123")
        let raceResults = [
                    RaceResult(number: "33", position: "1", positionText: "1", points: "25",
                               driver: Driver(driverID: "1", permanentNumber: "33", code: "VER", url: "",
                               givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch"),
                               constructor: Constructor(constructorID: "red_bull", url: "", name: "Red Bull Racing", nationality: "Austrian"),
                               grid: "1", laps: "53", status: "Finished", time: resultTime, fastestLap: nil),
                    RaceResult(number: "44", position: "1", positionText: "1", points: "25",
                               driver: Driver(driverID: "1", permanentNumber: "44", code: "HAM", url: "",
                               givenName: "Lewis", familyName: "Hamilton", dateOfBirth: "1997-09-30", nationality: "British"),
                               constructor: Constructor(constructorID: "red_bull", url: "", name: "Red Bull Racing", nationality: "Austrian"),
                               grid: "1", laps: "53", status: "Finished", time: resultTime, fastestLap: nil)
                ]
       let race = Race(season: "2024", round: "1", url: "", raceName: "Italian GP",
                                circuit: Circuit(circuitID: "monza", circuitName: "Monza", url: "",
                                location: Location(latitude: "", longitude: "", locality: "", country: "Italy")),
                                date: "2024-09-02", time: "15:00", results: raceResults)
        mockRepository.mockResults = RacingResults(results: ResultsResponse(series: "F1", url: "", limit: "10", offset: "0", total: "1", raceTable: RaceTable(season: "2024", races: [race])))

        viewModel.fetchConstructor(constructorName: "mercedes")

        XCTAssertEqual(viewModel.drivers, "VER | HAM")
    }

    func testDriversEmpty() {
        XCTAssertEqual(viewModel.drivers, " | ")
    }

    func testResultAtIndex_ValidIndex() {
        let race = Race(season: "2024", round: "1", url: "", raceName: "Italian GP",
                                circuit: Circuit(circuitID: "monza", circuitName: "Monza", url: "",
                               location: Location(latitude: "", longitude: "", locality: "", country: "Italy")),
                               date: "2024-09-02", time: "15:00", results: [])
        mockRepository.mockResults = RacingResults(results: ResultsResponse(series: "F1", url: "", limit: "10", offset: "0", total: "1", raceTable: RaceTable(season: "2024", races: [race])))
        viewModel.fetchConstructor(constructorName: "mercedes")
        let fetchedRace = viewModel.result(atIndex: 0)
        XCTAssertEqual(fetchedRace?.raceName, "Italian GP")
    }

    func testResultAtIndex_InvalidIndex() {
        let fetchedRace = viewModel.result(atIndex: 0)
        XCTAssertNil(fetchedRace)
    }

    func testResultAtIndex_InvalidResult() {
        mockRepository.mockResults = nil
        let fetchedRace = viewModel.result(atIndex: 0)
        XCTAssertNil(fetchedRace)
    }

    func testConstructorImageName() {
        viewModel.setConstructor(constructor:
                ConstructorStanding(position: "1", positionText: "1", points: "100", wins: "5", constructor: Constructor(constructorID: "mercedes", url: "", name: "Mercedes", nationality: "German")))

        XCTAssertEqual(viewModel.constructorImageName, "mercedes.png")
    }

    func testConstructorName() {
        viewModel.setConstructor(constructor:
                ConstructorStanding(position: "1", positionText: "1", points: "100", wins: "5", constructor: Constructor(constructorID: "mercedes", url: "", name: "Mercedes", nationality: "German")))

        XCTAssertEqual(viewModel.constructorName, "Mercedes")
    }

    func testConstructorNationality() {
        viewModel.setConstructor(constructor:
                ConstructorStanding(position: "1", positionText: "1", points: "100", wins: "5", constructor: Constructor(constructorID: "mercedes", url: "", name: "Mercedes", nationality: "German")))

        XCTAssertEqual(viewModel.constructorNationality, "German")
    }

    func testCurrentPosition() {
        viewModel.setConstructor(constructor:
                ConstructorStanding(position: "1", positionText: "1", points: "100", wins: "5", constructor: Constructor(constructorID: "mercedes", url: "", name: "Mercedes", nationality: "German")))

        XCTAssertEqual(viewModel.currentPosition, "1")
    }

    func testCurrentPoints() {
        viewModel.setConstructor(constructor:
                ConstructorStanding(position: "1", positionText: "1", points: "100", wins: "5", constructor: Constructor(constructorID: "mercedes", url: "", name: "Mercedes", nationality: "German")))

        XCTAssertEqual(viewModel.currentPoints, "100")
    }

    func testCurrentWins() {
        viewModel.setConstructor(constructor:
                ConstructorStanding(position: "1", positionText: "1", points: "100", wins: "5", constructor: Constructor(constructorID: "mercedes", url: "", name: "Mercedes", nationality: "German")))

        XCTAssertEqual(viewModel.currentWins, "5")
    }
}
