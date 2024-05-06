//
//  DriverStandingsViewModelTests.swift
//  F1Tests
//
//  Created by Kaitlyn Sookdhew on 2024/05/05.
//

class MockDriverStandingsRepository: DriverStandingsRepositoryType {
    var shouldReturnError: Bool = false
    var mockDriverStandings: DriverStandingsModel?

    func fetchDriverStandingsResults(completion: @escaping (DriverStandingsResults)) {
        if shouldReturnError {
            completion(.failure(.serverError))
        } else {
            completion(.success(mockDriverStandings ?? DriverStandingsModel(driverStandings: DriverStandingsResponse(series: "F1", url: "", limit: "10", offset: "0", total: "1",
                                                                                                                     standingsTable: DriverStandingsTable(season: "2024", standingsLists: [])))))
        }
    }
}

import XCTest
@testable import F1

class DriverStandingsViewModelTests: XCTestCase {
    var viewModel: DriverStandingsViewModel!
    var mockRepository: MockDriverStandingsRepository!
    var mockDelegate: MockViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockRepository = MockDriverStandingsRepository()
        mockDelegate = MockViewModelDelegate()
        viewModel = DriverStandingsViewModel(repository: mockRepository, delegate: mockDelegate)
    }

    func testFetchDriverStandings_Success() {
        let driverStandings = [
        DriverStanding(
            position: "1",
            positionText: "1",
            points: "25",
            wins: "1",
            driver: Driver(
                driverID: "max_verstappen",
                permanentNumber: "33",
                code: "VER",
                url: "",
                givenName: "Max",
                familyName: "Verstappen",
                dateOfBirth: "1997-09-30",
                nationality: "Dutch"
            ),
            constructors: [
                Constructor(
                    constructorID: "red_bull",
                    url: "",
                    name: "Red Bull Racing",
                    nationality: "Austrian"
                )
            ]
        )
    ]

    mockRepository.mockDriverStandings = DriverStandingsModel(
        driverStandings: DriverStandingsResponse(
            series: "F1",
            url: "",
            limit: "10",
            offset: "0",
            total: "1",
            standingsTable: DriverStandingsTable(
                season: "2024",
                standingsLists: [
                    DriverStandingsList(
                        season: "2024",
                        round: "1",
                        driverStandings: driverStandings
                    )
                ]
            )
        )
    )

        viewModel.fetchDriverStandings()

        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertEqual(viewModel.driversCount, 1)
        XCTAssertNotNil(viewModel.driver(atIndex: 0))
    }

    func testFetchDriverStandings_Failure() {
        mockRepository.shouldReturnError = true
        viewModel.fetchDriverStandings()

        XCTAssertTrue(mockDelegate.showErrorCalled)
        XCTAssertEqual(viewModel.driversCount, 0)
    }

    func testSetConstructors() {
        let driver = Driver(driverID: "driver1", permanentNumber: "44", code: "HAM", url: "", givenName: "Lewis", familyName: "Hamilton", dateOfBirth: "1985-01-07", nationality: "British")
        let driverStandings = [
            DriverStanding(
                position: "1",
                positionText: "1",
                points: "320",
                wins: "5",
                driver: driver,
                constructors: [
                    Constructor(
                        constructorID: "mercedes",
                        url: "",
                        name: "Mercedes",
                        nationality: "German"
                    )
                ]
            )
        ]

        mockRepository.mockDriverStandings = DriverStandingsModel(
            driverStandings: DriverStandingsResponse(
                series: "F1",
                url: "",
                limit: "10",
                offset: "0",
                total: "1",
                standingsTable: DriverStandingsTable(
                    season: "2024",
                    standingsLists: [
                        DriverStandingsList(
                            season: "2024",
                            round: "1",
                            driverStandings: driverStandings
                        )
                    ]
                )
            )
        )
        viewModel.fetchDriverStandings()
        viewModel.setConstructors()

        let drivers = viewModel.getConstructorDrivers(constructorID: "mercedes")
        XCTAssertEqual(drivers?.count, 1)
        XCTAssertEqual(drivers?.first??.givenName, "Lewis")
    }

    func testConstructorDrivers_NoConstructors() {
        viewModel.setConstructors()
        let drivers = viewModel.getConstructorDrivers(constructorID: "ferrari")
        XCTAssertTrue(drivers?.isEmpty ?? false)
    }
}
