//
//  DriverRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation

typealias DriverResults = (Result< DriverModel, APIError>) -> Void

protocol DriverRepositoryType: AnyObject {
    
    func fetchDriverResults(driver : String,completion: @escaping(DriverResults))
}


class DriverRepository: DriverRepositoryType {
    
    func fetchDriverResults(driver : String, completion: @escaping (DriverResults)) {
        let url = "https://ergast.com/api/f1/drivers/\(driver).JSON"
        URLSession.shared.request(endpoint: url, method: .GET, completion: completion)
    }
    
}
