//
//  LoginRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/10.
//

import Foundation

typealias LoginResults = (Result< LoginModel, APIError>) -> Void

protocol LoginRepositoryType: AnyObject {

    func fetchAuthResults()
}


class LoginRepository: LoginRepositoryType {

    func fetchAuthResults() {
        
    }

}
