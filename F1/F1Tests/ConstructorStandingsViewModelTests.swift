//
//  ConstructorStandingsViewModelTests.swift
//  F1Tests
//
//  Created by Kaitlyn Sookdhew on 2024/05/06.
//
import XCTest
@testable import F1

class MockConstructorStandingsRepository: ConstructorStandingsRepositoryType {
    var shouldReturnError = false
    var mockConstructorStandings: ConstructorStandingsModel?

    func fetchConstructorStandingsResults(completion: @escaping (ConstructorStandingsResults)) {
        if shouldReturnError {
            completion(.failure(.serverError))
        } else {
            completion(.success(mockConstructorStandings ?? ConstructorStandingsModel(constructorStandings: ConstructorStandingsResponse(
                series: "F1", url: "", limit: "10", offset: "0", total: "1", standingsTable: ConstructorStandingsTable(season: "2024", standingsLists: [])))))
        }
    }

    func fetchConstructorStandingsResultsOffline(completion: @escaping (ConstructorStandingsResults)) {
        if shouldReturnError {
            completion(.failure(.serverError))
        } else {
            completion(.success(mockConstructorStandings ?? ConstructorStandingsModel(constructorStandings: ConstructorStandingsResponse(
                series: "F1", url: "", limit: "10", offset: "0", total: "1", standingsTable: ConstructorStandingsTable(season: "2024", standingsLists: [])))))
        }
    }
}

class ConstructorStandingsViewModelTests: XCTestCase {
    var viewModel: ConstructorStandingsViewModel!
    var mockRepository: MockConstructorStandingsRepository!
    var mockDelegate: MockViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockRepository = MockConstructorStandingsRepository()
        mockDelegate = MockViewModelDelegate()
        viewModel = ConstructorStandingsViewModel(repository: mockRepository)
    }

    func testFetchConstructorStandings_Success() {
        let constructorStandings = [
            ConstructorStanding(position: "1", positionText: "1", points: "400", wins: "12",
                                constructor: Constructor(constructorID: "ferrari", url: "", name: "Ferrari", nationality: "Italian"))
        ]
        mockRepository.mockConstructorStandings = ConstructorStandingsModel(
            constructorStandings: ConstructorStandingsResponse(
                series: "F1",
                url: "",
                limit: "10",
                offset: "0",
                total: "1",
                standingsTable: ConstructorStandingsTable(
                    season: "2024",
                    standingsLists: [
                        ConstructorStandingsList(
                            season: "2024",
                            round: "1",
                            constructorStandings: constructorStandings
                        )
                    ]
                )
            )
        )

        let expectation = self.expectation(description: "Fetch Constructor Standings Success")
        viewModel.fetchConstructorStandings { standings in
            XCTAssertEqual(self.viewModel.constructorCount, 1)
            XCTAssertNotNil(self.viewModel.constructor(atIndex: 0))
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testFetchConstructorStandings_Failure() {
        mockRepository.shouldReturnError = true

        let expectation = self.expectation(description: "Fetch Constructor Standings Failure")
        viewModel.fetchConstructorStandings { standings in
            XCTAssertEqual(self.viewModel.constructorCount, 0)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testConstructorAtIndex_Nil() {
        XCTAssertNil(viewModel.constructor(atIndex: 0), "Should return nil when no data is loaded")
    }

    func testDrivers_Empty() {
        XCTAssertEqual(viewModel.drivers(driversList: []), "", "Should return empty string for no drivers")
    }

    func testDrivers_OneDriver() {
        let drivers = [Driver(driverID: "max_verstappen", permanentNumber: "33", code: "VER", url: "", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch")]
        XCTAssertEqual(viewModel.drivers(driversList: drivers), "VER", "Should return driver code for one driver")
    }

    func testDrivers_TwoDrivers() {
        let drivers = [
            Driver(driverID: "max_verstappen", permanentNumber: "33", code: "VER", url: "", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch"),
            Driver(driverID: "lewis_hamilton", permanentNumber: "44", code: "HAM", url: "", givenName: "Lewis", familyName: "Hamilton", dateOfBirth: "1985-01-07", nationality: "British")
        ]
        XCTAssertEqual(viewModel.drivers(driversList: drivers), "VER/HAM", "Should return concatenated driver codes for two drivers")
    }

    func testEmptyDriver() {
        let firstResult = viewModel.drivers(driversList: [nil, nil, nil])
        XCTAssertEqual(firstResult, "")

        let secondResult = viewModel.drivers(driversList: [nil])
        XCTAssertEqual(secondResult, "")
    }
}
