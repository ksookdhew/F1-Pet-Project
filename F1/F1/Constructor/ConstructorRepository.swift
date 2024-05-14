//
//  ConstructorRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

// MARK: Typealias
typealias ConstructorResults = (Result<RacingResults, APIError>) -> Void

// MARK: Protocol
protocol ConstructorRepositoryType: AnyObject {
    func fetchConstructorResults(constructor: String, completion: @escaping ConstructorResults)
}

// MARK: Repository
class ConstructorRepository: ConstructorRepositoryType {

    func fetchConstructorResults(constructor: String, completion: @escaping ConstructorResults) {
        let url = Endpoints.constructor + "\(constructor)/results.JSON"
        URLSession.shared.request(endpoint: url, method: .GET, completion: completion)
    }
}
