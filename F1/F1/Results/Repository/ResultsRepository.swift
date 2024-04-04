//
//  ResultsRepository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import Foundation
typealias ResultsResults = (Result< ResultsModel, APIError>) -> Void

protocol ResultsRepositoryType: AnyObject {
    func fetchResultsResults(round : String,completion: @escaping(ResultsResults))
}


class ResultsRepository: ResultsRepositoryType {
  
    func fetchResultsResults(round : String, completion: @escaping (ResultsResults)) {
        let url = "https://ergast.com/api/f1/current/\(round)/results.JSON"
        print(url)
        URLSession.shared.request(endpoint: url, method: .GET, completion: completion)
    }
    
}
