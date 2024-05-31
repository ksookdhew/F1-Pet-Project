//
//  DriverViewModelTests.swift
//  F1Tests
//
//  Created by Kaitlyn Sookdhew on 2024/05/06.
//

import XCTest
@testable import F1

class MockDriverRepository: DriverRepositoryType {
    var shouldReturnError = false
    var mockResults: RacingResults?

    func fetchDriverResults(driver: String, completion: @escaping DriverResults) {
        if shouldReturnError {
            completion(.failure(.serverError))
        } else {
            completion(.success(mockResults ?? RacingResults(results: ResultsResponse(series: "F1", url: "",
                        limit: "10", offset: "0", total: "1", raceTable: RaceTable(season: "2024", races: [])))))
        }
    }
}

final class DriverViewModelTests: XCTestCase {
    var viewModel: DriverViewModel!
    var mockRepository: MockDriverRepository!
    var mockDelegate: MockViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockRepository = MockDriverRepository()
        mockDelegate = MockViewModelDelegate()
        viewModel = DriverViewModel(repository: mockRepository, delegate: mockDelegate)
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

        viewModel.fetchDriver(driverName: "max_verstappen")

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

        viewModel.fetchDriver(driverName: nil)

        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertEqual(viewModel.resultsCount, 1)
    }

    func testFetchDriverResults_Failure() {
        mockRepository.shouldReturnError = true

        viewModel.fetchDriver(driverName: "max_verstappen")

        XCTAssertNotNil(mockDelegate.showErrorCalled)
        XCTAssertEqual(viewModel.resultsCount, 0)
    }

    func testResultAtIndex_ValidIndex() {
        let race = Race(season: "2024", round: "1", url: "", raceName: "Italian GP",
                            circuit: Circuit(circuitID: "monza", circuitName: "Monza", url: "",
                               location: Location(latitude: "", longitude: "", locality: "", country: "Italy")),
                               date: "2024-09-02", time: "15:00", results: [])
        mockRepository.mockResults = RacingResults(results: ResultsResponse(series: "F1", url: "", limit: "10", offset: "0", total: "1", raceTable: RaceTable(season: "2024", races: [race])))
        viewModel.fetchDriver(driverName: "max_verstappen")
        let fetchedRace = viewModel.result(atIndex: 0)
        XCTAssertEqual(fetchedRace?.raceName, "Italian GP")
    }

    func testResultAtIndex_InvalidIndex() {
        let fetchedRace = viewModel.result(atIndex: 0)
        XCTAssertNil(fetchedRace)
    }

    func testLaptime_ValidResult() {
        let resultTime = ResultTime(millis: "123456", time: "1:25.123")
        let raceResults = [
                    RaceResult(number: "33", position: "1", positionText: "1", points: "25",
                               driver: Driver(driverID: "1", permanentNumber: "33", code: "VER", url: "",
                               givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch"),
                               constructor: Constructor(constructorID: "red_bull", url: "", name: "Red Bull Racing", nationality: "Austrian"),
                               grid: "1", laps: "53", status: "Finished", time: resultTime, fastestLap: nil)
                ]
       let race = Race(season: "2024", round: "1", url: "", raceName: "Italian GP",
                                circuit: Circuit(circuitID: "monza", circuitName: "Monza", url: "",
                                location: Location(latitude: "", longitude: "", locality: "", country: "Italy")),
                                date: "2024-09-02", time: "15:00", results: raceResults)
        mockRepository.mockResults = RacingResults(results: ResultsResponse(series: "F1", url: "", limit: "10", offset: "0", total: "1", raceTable: RaceTable(season: "2024", races: [race])))
        viewModel.fetchDriver(driverName: "max_verstappen")

        let laptime = viewModel.laptime(index: 0)
        XCTAssertEqual(laptime, "1:25.123")
    }

    func testLaptime_NoTimeInfo() {
        let raceResults = [
                    RaceResult(number: "33", position: "1", positionText: "1", points: "25",
                               driver: Driver(driverID: "1", permanentNumber: "33", code: "VER", url: "",
                               givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch"),
                               constructor: Constructor(constructorID: "red_bull", url: "", name: "Red Bull Racing", nationality: "Austrian"),
                               grid: "1", laps: "53", status: "Retired", time: nil, fastestLap: nil)
                ]
                let race = Race(season: "2024", round: "1", url: "", raceName: "Italian GP",
                                circuit: Circuit(circuitID: "monza", circuitName: "Monza", url: "",
                                location: Location(latitude: "", longitude: "", locality: "", country: "Italy")),
                                date: "2024-09-02", time: "15:00", results: raceResults)
        mockRepository.mockResults = RacingResults(results: ResultsResponse(series: "F1", url: "", limit: "10", offset: "0", total: "1", raceTable: RaceTable(season: "2024", races: [race])))
        viewModel.fetchDriver(driverName: "max_verstappen")

        let laptime = viewModel.laptime(index: 0)
        XCTAssertEqual(laptime, "DNF")
    }

    func testLaptime_ContainsLap() {
        let raceResults = [
                    RaceResult(number: "33", position: "1", positionText: "1", points: "25",
                               driver: Driver(driverID: "1", permanentNumber: "33", code: "VER", url: "",
                               givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch"),
                               constructor: Constructor(constructorID: "red_bull", url: "", name: "Red Bull Racing", nationality: "Austrian"),
                               grid: "1", laps: "53", status: "+1 Lap", time: nil, fastestLap: nil)
                ]
                let race = Race(season: "2024", round: "1", url: "", raceName: "Italian GP",
                                circuit: Circuit(circuitID: "monza", circuitName: "Monza", url: "",
                                location: Location(latitude: "", longitude: "", locality: "", country: "Italy")),
                                date: "2024-09-02", time: "15:00", results: raceResults)
        mockRepository.mockResults = RacingResults(results: ResultsResponse(series: "F1", url: "", limit: "10", offset: "0", total: "1", raceTable: RaceTable(season: "2024", races: [race])))
        viewModel.fetchDriver(driverName: "max_verstappen")

        let laptime = viewModel.laptime(index: 0)
        XCTAssertEqual(laptime, "+1 Lap")
    }

    func testLaptime_NoTime() {
        let laptime = viewModel.laptime(index: 0)
        XCTAssertEqual(laptime, "No Time")
    }

    func testImageName() {
        let validImage = viewModel.imageName(driverCode: "HAM")
        XCTAssertEqual(validImage, "HAM.png")

        let invalidImage = viewModel.imageName(driverCode: nil)
        XCTAssertEqual(invalidImage, ".png")
    }

    func testDriverImageName() {
        viewModel.setDriver(driver: DriverStanding( position: "1", positionText: "1", points: "100", wins: "5",
            driver: Driver(driverID: "1", permanentNumber: "33", code: "VER", url: "", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch"),
            constructors: [Constructor(constructorID: "red_bull", url: "", name: "Red Bull Racing", nationality: "Austrian")]))

        XCTAssertEqual(viewModel.driverImageName, "VER.png")
    }

    func testDriverGivenName() {
        viewModel.setDriver(driver: DriverStanding( position: "1", positionText: "1", points: "100", wins: "5",
            driver: Driver(driverID: "1", permanentNumber: "33", code: "VER", url: "", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch"),
            constructors: [Constructor(constructorID: "red_bull", url: "", name: "Red Bull Racing", nationality: "Austrian")]))

        XCTAssertEqual(viewModel.driverGivenName, "Max")
    }

    func testDriverFamilyName() {
        viewModel.setDriver(driver: DriverStanding( position: "1", positionText: "1", points: "100", wins: "5",
            driver: Driver(driverID: "1", permanentNumber: "33", code: "VER", url: "", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch"),
            constructors: [Constructor(constructorID: "red_bull", url: "", name: "Red Bull Racing", nationality: "Austrian")]))

        XCTAssertEqual(viewModel.driverFamilyName, "Verstappen")
    }

    func testDriverConstructorInfo() {
        viewModel.setDriver(driver: DriverStanding( position: "1", positionText: "1", points: "100", wins: "5",
            driver: Driver(driverID: "1", permanentNumber: "33", code: "VER", url: "", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch"),
            constructors: [Constructor(constructorID: "red_bull", url: "", name: "Red Bull Racing", nationality: "Austrian")]))

        XCTAssertEqual(viewModel.driverConstructorInfo, "33 | Red Bull Racing")
    }

    func testDriverNationality() {
        viewModel.setDriver(driver: DriverStanding( position: "1", positionText: "1", points: "100", wins: "5",
            driver: Driver(driverID: "1", permanentNumber: "33", code: "VER", url: "", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch"),
            constructors: [Constructor(constructorID: "red_bull", url: "", name: "Red Bull Racing", nationality: "Austrian")]))

        XCTAssertEqual(viewModel.driverNationality, "Dutch")
    }

    func testDriverCurrentPosition() {
        viewModel.setDriver(driver: DriverStanding( position: "1", positionText: "1", points: "100", wins: "5",
            driver: Driver(driverID: "1", permanentNumber: "33", code: "VER", url: "", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch"),
            constructors: [Constructor(constructorID: "red_bull", url: "", name: "Red Bull Racing", nationality: "Austrian")]))

        XCTAssertEqual(viewModel.currentPosition, "1")
    }

    func testDriverCurrentPoints() {
        viewModel.setDriver(driver: DriverStanding( position: "1", positionText: "1", points: "100", wins: "5",
            driver: Driver(driverID: "1", permanentNumber: "33", code: "VER", url: "", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch"),
            constructors: [Constructor(constructorID: "red_bull", url: "", name: "Red Bull Racing", nationality: "Austrian")]))

        XCTAssertEqual(viewModel.currentPoints, "100")
    }

    func testDriverCurrentWins() {
        viewModel.setDriver(driver: DriverStanding( position: "1", positionText: "1", points: "100", wins: "5",
            driver: Driver(driverID: "1", permanentNumber: "33", code: "VER", url: "", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch"),
            constructors: [Constructor(constructorID: "red_bull", url: "", name: "Red Bull Racing", nationality: "Austrian")]))

        XCTAssertEqual(viewModel.currentWins, "5")
    }

    func testEmptydriverConstructorInfo() {
        XCTAssertEqual(viewModel.driverConstructorInfo, " | ")
    }
}
