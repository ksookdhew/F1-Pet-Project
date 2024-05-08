//
//  LoginViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/10.
//

import Foundation

class LoginViewModel {

    // MARK: Variables
    private let username = "Admin"
    private let password = "Password"

    // MARK: Functions
    func validDetails(givenUsername: String?, givenPassword: String?) -> Bool {
        givenUsername == username && givenPassword == password
    }
}
