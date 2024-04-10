//
//  LoginViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/10.
//

import Foundation

class LoginViewModel {
    private let username="Admin"
    private let password = "Password"

    func validDetails(givenUsername: String, givenPassword: String) -> Bool{
        if givenUsername==username && givenPassword==password {
            return true
        } else {
            return false
        }
    }

}

