//
//  F1Repository.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//


import Foundation

typealias ConstructorStandingsResults = (Result< ConstructorStandingsModel, APIError>) -> Void
typealias DriverStandingsResults = (Result< DriverStandingsModel, APIError>) -> Void

protocol F1RepositoryType: AnyObject {
    func fetchConstructorStandingsResults(completion: @escaping(ConstructorStandingsResults))
    func fetchDriverStandingsResults(completion: @escaping(DriverStandingsResults))
}

class F1Repository: F1RepositoryType {
    func fetchConstructorStandingsResults(completion: @escaping (ConstructorStandingsResults)) {
        request(endpoint: "https:ergast.com/api/f1/current/constructorStandings.JSON", method: .GET, completion: completion)
    }
    
    func fetchDriverStandingsResults(completion: @escaping (DriverStandingsResults)) {
        request(endpoint: "https://ergast.com/api/f1/current/driverStandings.JSON", method: .GET, completion: completion)
    }
    
    private func request<T: Codable>(endpoint: String, method: Method, completion: @escaping((Result<T, APIError>) -> Void)) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.internalError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        call(with: request, completion: completion)
    }
    
    private func call<T: Codable>(with request: URLRequest, completion: @escaping((Result<T, APIError>) -> Void)) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async() {
                    completion(.failure(.serverError))
                }
                return
            }
            do {
                guard let data = data else {
                    DispatchQueue.main.async() {
                        completion(.failure(.serverError))
                    }
                    return
                }
                let object = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async() {
                    completion(Result.success(object))
                }
            } catch {
                DispatchQueue.main.async() {
                    completion(Result.failure(.parsingError))
                }
            }
        }
        dataTask.resume()
    }
}

