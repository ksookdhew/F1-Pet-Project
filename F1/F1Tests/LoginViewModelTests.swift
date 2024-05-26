//
//  LoginViewModelTests.swift
//  F1Tests
//
//  Created by Kaitlyn Sookdhew on 2024/05/06.
//

import XCTest
@testable import F1

class MockLoginNavigationDelegate: LoginNavigationDelegate {
    var navigateCalled = false

    func navigate() {
        navigateCalled = true
    }
}

final class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var mockNavigationDelegate: MockLoginNavigationDelegate!

    override func setUp() {
        super.setUp()
        mockNavigationDelegate = MockLoginNavigationDelegate()
        viewModel = LoginViewModel(navigationDelegate: mockNavigationDelegate)
    }

    override func tearDown() {
        viewModel = nil
        mockNavigationDelegate = nil
        super.tearDown()
    }

    func testValidDetails_CorrectCredentials_ReturnsTrue() {

        let username = "Admin"
        let password = "Password"
        let isValid = viewModel.validDetails(givenUsername: username, givenPassword: password)

        XCTAssertTrue(isValid)
    }

    func testValidDetails_IncorrectUsername_ReturnsFalse() {

        let username = "User"
        let password = "Password"
        let isValid = viewModel.validDetails(givenUsername: username, givenPassword: password)

        XCTAssertFalse(isValid)
    }

    func testValidDetails_IncorrectPassword_ReturnsFalse() {

        let username = "Admin"
        let password = "12345"
        let isValid = viewModel.validDetails(givenUsername: username, givenPassword: password)

        XCTAssertFalse(isValid, "validDetails should return false for incorrect password")
    }

    func testValidDetails_IncorrectUsernameAndPassword_ReturnsFalse() {

        let username = "User"
        let password = "12345"
        let isValid = viewModel.validDetails(givenUsername: username, givenPassword: password)

        XCTAssertFalse(isValid, "validDetails should return false for incorrect username and password")
    }

    func testPerformSegue_NavigateCalledOnValidDetails() {
            let username = "Admin"
            let password = "Password"
            _ = viewModel.validDetails(givenUsername: username, givenPassword: password)
            viewModel.performSegue()

            XCTAssertTrue(mockNavigationDelegate.navigateCalled)
        }
}
