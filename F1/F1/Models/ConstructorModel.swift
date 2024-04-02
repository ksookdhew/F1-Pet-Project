//
//  ConstructorModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

// MARK: - ConstructorModel
struct ConstructorModel: Codable {
    let mrData: ConstructorData

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - ConstructorData
struct ConstructorData: Codable {
    let xmlns: String
    let series: String
    let url: String
    let limit, offset, total: String
    let constructorTable: ConstructorTable

    enum CodingKeys: String, CodingKey {
        case xmlns, series, url, limit, offset, total
        case constructorTable = "ConstructorTable"
    }
}

// MARK: - ConstructorTable
struct ConstructorTable: Codable {
    let season: String
    let constructors: [Constructor]

    enum CodingKeys: String, CodingKey {
        case season
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

