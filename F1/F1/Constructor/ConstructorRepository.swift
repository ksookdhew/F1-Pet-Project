//
//  ConstructorRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

typealias ConstructorResults = (Result< ResultsModel, APIError>) -> Void

protocol ConstructorRepositoryType: AnyObject {
    func fetchConstructorResults(constructor : String,completion: @escaping(ConstructorResults))
}

class ConstructorRepository: ConstructorRepositoryType {

    func fetchConstructorResults(constructor: String, completion: @escaping (ConstructorResults)) {
        let url = "https://ergast.com/api/f1/current/constructors/\(constructor)/results.JSON"
        URLSession.shared.request(endpoint: url, method: .GET, completion: completion)
    }
}
