//
//  ConstructorModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

// MARK: - ConstructorModel
struct ConstructorModel: Codable {
    let constructor: ConstructorResponse

    enum CodingKeys: String, CodingKey {
        case constructor = "MRData"
    }
}

// MARK: - ConstructorResponse
struct ConstructorResponse: Codable {
    let series: String
    let url: String
    let limit, offset, total: String
    let constructorTable: ConstructorTable

    enum CodingKeys: String, CodingKey {
        case series, url, limit, offset, total
        case constructorTable = "ConstructorTable"
    }
}

// MARK: - ConstructorTable
struct ConstructorTable: Codable {
    let constructorID: String
    let constructors: [Constructor]

    enum CodingKeys: String, CodingKey {
        case constructorID = "constructorId"
        case constructors = "Constructors"
    }
}

// MARK: - Constructor
struct Constructor: Codable {
    let constructorID: String
    let url: String
    let name, nationality: String

    enum CodingKeys: String, CodingKey {
        case constructorID = "constructorId"
        case url, name, nationality
    }
}
