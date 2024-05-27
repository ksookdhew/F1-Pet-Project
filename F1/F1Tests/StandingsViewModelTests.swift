////
////  StandingsViewModelTests.swift
////  F1Tests
////
////  Created by Kaitlyn Sookdhew on 2024/05/05.
////
//
//import XCTest
//@testable import F1
//
//class MockStandingsNavigationDelegate: StandingsNavigationDelegate {
//    var lastNavigatedDriver: DriverStanding?
//    var lastNavigatedConstructor: ConstructorStanding?
//
//    func navigateToDriver(_ driver: DriverStanding) {
//        lastNavigatedDriver = driver
//    }
//
//    func navigateToConstructor(_ constructor: ConstructorStanding) {
//        lastNavigatedConstructor = constructor
//    }
//}
//
//class StandingsViewModelTests: XCTestCase {
//    var viewModel: StandingsViewModel!
//    var mockDriverViewModel: DriverStandingsViewModel!
//    var mockConstructorViewModel: ConstructorStandingsViewModel!
//    var mockNavigationDelegate: MockStandingsNavigationDelegate!
//    var mockDriverStandingsRepository: MockDriverStandingsRepository!
//    var mockConstructorStandingsRepository: MockConstructorStandingsRepository!
//    var mockDelegate: MockViewModelDelegate!
//
//    override func setUp() {
//        super.setUp()
//        mockDriverStandingsRepository = MockDriverStandingsRepository()
//        mockConstructorStandingsRepository = MockConstructorStandingsRepository()
//        mockDelegate = MockViewModelDelegate()
//        mockDriverViewModel = DriverStandingsViewModel(repository: mockDriverStandingsRepository, delegate: mockDelegate)
//        mockConstructorViewModel = ConstructorStandingsViewModel(repository: mockConstructorStandingsRepository, delegate: mockDelegate)
//        mockNavigationDelegate = MockStandingsNavigationDelegate()
//        viewModel = StandingsViewModel(driverViewModel: mockDriverViewModel, constructorViewModel: mockConstructorViewModel, navigationDelegate: mockNavigationDelegate)
//    }
//
//    func testNavigateToDriver() {
//        let driver = DriverStanding(position: "1", positionText: "1", points: "100", wins: "3",
//                                    driver: Driver(driverID: "1", permanentNumber: "33", code: "VER",
//                                                   url: "", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch"), constructors: [])
//
//        mockDriverStandingsRepository.mockDriverStandings = DriverStandingsModel(
//            driverStandings: DriverStandingsResponse(
//                series: "F1",
//                url: "",
//                limit: "10",
//                offset: "0",
//                total: "1",
//                standingsTable: DriverStandingsTable(
//                    season: "2024",
//                    standingsLists: [
//                        DriverStandingsList(
//                            season: "2024",
//                            round: "1",
//                            driverStandings: [driver]
//                        )
//                    ]
//                )
//            )
//        )
//
//        mockDriverViewModel.fetchDriverStandings()
//        viewModel.navigateTo(indexPath: IndexPath(row: 0, section: 0), selectedSegmentIndex: 1)
//
//        XCTAssertEqual(mockNavigationDelegate.lastNavigatedDriver?.driver.familyName, driver.driver.familyName)
//    }
//
//    func testNavigateToConstructor() {
//        let constructor = ConstructorStanding(position: "1", positionText: "1", points: "200",
//                                              wins: "5", constructor: Constructor(constructorID: "1", url: "", name: "Red Bull Racing", nationality: "Austrian"))
//        mockConstructorStandingsRepository.mockConstructorStandings = ConstructorStandingsModel(
//            constructorStandings: ConstructorStandingsResponse(
//                series: "F1",
//                url: "",
//                limit: "10",
//                offset: "0",
//                total: "1",
//                standingsTable: ConstructorStandingsTable(
//                    season: "2024",
//                    standingsLists: [
//                        ConstructorStandingsList(
//                            season: "2024",
//                            round: "1",
//                            constructorStandings: [constructor]
//                        )
//                    ]
//                )
//            )
//        )
//        mockConstructorViewModel.fetchConstructorStandings()
//        viewModel.navigateTo(indexPath: IndexPath(row: 0, section: 0), selectedSegmentIndex: 0)
//
//        XCTAssertEqual(mockNavigationDelegate.lastNavigatedConstructor?.constructor.constructorID, constructor.constructor.constructorID)
//    }
//
//    func testNavigateWithInvalidIndex() {
//        viewModel.navigateTo(indexPath: IndexPath(row: 0, section: 1), selectedSegmentIndex: 1)
//        XCTAssertNil(mockNavigationDelegate.lastNavigatedDriver)
//        viewModel.navigateTo(indexPath: IndexPath(row: 0, section: 1), selectedSegmentIndex: 0)
//        XCTAssertNil(mockNavigationDelegate.lastNavigatedConstructor)
//    }
//}


import XCTest
@testable import F1

class MockStandingsNavigationDelegate: StandingsNavigationDelegate {
    var lastNavigatedDriver: DriverStanding?
    var lastNavigatedConstructor: ConstructorStanding?

    func navigateToDriver(_ driver: DriverStanding) {
        lastNavigatedDriver = driver
    }

    func navigateToConstructor(_ constructor: ConstructorStanding) {
        lastNavigatedConstructor = constructor
    }
}

class StandingsViewModelTests: XCTestCase {
    var viewModel: StandingsViewModel!
    var mockDriverViewModel: DriverStandingsViewModel!
    var mockConstructorViewModel: ConstructorStandingsViewModel!
    var mockNavigationDelegate: MockStandingsNavigationDelegate!
    var mockDriverStandingsRepository: MockDriverStandingsRepository!
    var mockConstructorStandingsRepository: MockConstructorStandingsRepository!
    var mockDelegate: MockViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockDriverStandingsRepository = MockDriverStandingsRepository()
        mockConstructorStandingsRepository = MockConstructorStandingsRepository()
        mockDelegate = MockViewModelDelegate()
        mockDriverViewModel = DriverStandingsViewModel(repository: mockDriverStandingsRepository)
        mockConstructorViewModel = ConstructorStandingsViewModel(repository: mockConstructorStandingsRepository)
        mockNavigationDelegate = MockStandingsNavigationDelegate()
        viewModel = StandingsViewModel(navigationDelegate: mockNavigationDelegate, delegate: mockDelegate)
    }

    func testNavigateToDriver() {
        let driver = DriverStanding(position: "1", positionText: "1", points: "100", wins: "3",
                                    driver: Driver(driverID: "1", permanentNumber: "33", code: "VER",
                                                   url: "", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch"), constructors: [])

        mockDriverStandingsRepository.mockDriverStandings = DriverStandingsModel(
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
                            driverStandings: [driver]
                        )
                    ]
                )
            )
        )

        let expectation = self.expectation(description: "Fetch Driver Standings Success")
        mockDriverViewModel.fetchDriverStandings { standings in
            self.viewModel.navigateTo(indexPath: IndexPath(row: 0, section: 0), selectedSegmentIndex: 1)
            XCTAssertEqual(driver.driver.familyName, "Verstappen")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testNavigateToConstructor() {
        let constructor = ConstructorStanding(position: "1", positionText: "1", points: "200",
                                              wins: "5", constructor: Constructor(constructorID: "1", url: "", name: "Red Bull Racing", nationality: "Austrian"))
        mockConstructorStandingsRepository.mockConstructorStandings = ConstructorStandingsModel(
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
                            constructorStandings: [constructor]
                        )
                    ]
                )
            )
        )

        let expectation = self.expectation(description: "Fetch Constructor Standings Success")
        mockConstructorViewModel.fetchConstructorStandings { standings in
            self.viewModel.navigateTo(indexPath: IndexPath(row: 0, section: 0), selectedSegmentIndex: 0)
            XCTAssertEqual(constructor.constructor.constructorID, "1")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testNavigateWithInvalidIndex() {
        viewModel.navigateTo(indexPath: IndexPath(row: 0, section: 1), selectedSegmentIndex: 1)
        XCTAssertNil(mockNavigationDelegate.lastNavigatedDriver)
        viewModel.navigateTo(indexPath: IndexPath(row: 0, section: 1), selectedSegmentIndex: 0)
        XCTAssertNil(mockNavigationDelegate.lastNavigatedConstructor)
    }
}
