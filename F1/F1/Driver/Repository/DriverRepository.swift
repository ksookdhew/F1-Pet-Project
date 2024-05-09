//
//  DriverRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation

// MARK: Typealias
typealias DriverResults = (Result< RacingResults, APIError>) -> Void

// MARK: Protocol
protocol DriverRepositoryType: AnyObject {

    func fetchDriverResults(driver: String, completion: @escaping DriverResults)
}

// MARK: Repository
class DriverRepository: DriverRepositoryType {

    func fetchDriverResults(driver: String, completion: @escaping DriverResults) {
        let url = Endpoints.driver + "\(driver)/results.JSON"
        URLSession.shared.request(endpoint: url, method: .GET, completion: completion)
    }

}
