//
//  LoginViewModelTests.swift
//  F1Tests
//
//  Created by Kaitlyn Sookdhew on 2024/05/06.
//

import XCTest
@testable import F1

final class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!

    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }

    override func tearDown() {
        viewModel = nil
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
}
