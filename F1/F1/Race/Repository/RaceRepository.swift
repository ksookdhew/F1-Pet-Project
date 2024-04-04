//
//  RaceRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation
typealias RaceResults = (Result< RaceModel, APIError>) -> Void

protocol RaceRepositoryType: AnyObject {
    func fetchRaceResults(round : String,completion: @escaping(RaceResults))
}



class RaceRepository: RaceRepositoryType {
  
    func fetchRaceResults(round : String, completion: @escaping (RaceResults)) {
        let url = "https://ergast.com/api/f1/current/\(round).JSON"
        URLSession.shared.request(endpoint: url, method: .GET, completion: completion)
    }
    
}