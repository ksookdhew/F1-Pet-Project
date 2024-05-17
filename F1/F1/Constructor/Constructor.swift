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
    let series, url, limit, offset, total: String
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
    let constructorID, url, name, nationality: String
    
    enum CodingKeys: String, CodingKey {
        case constructorID = "constructorId"
        case url, name, nationality
    }
    
    init(from coreDataConstructor: CoreDataConstructor) {
        self.constructorID = coreDataConstructor.constructorID ?? ""
        self.url = coreDataConstructor.url ?? ""
        self.name = coreDataConstructor.name ?? ""
        self.nationality = coreDataConstructor.nationality ?? ""
    }
    
    init(constructorID: String, url: String, name: String, nationality: String) {
        self.constructorID = constructorID
        self.url = url
        self.name = name
        self.nationality = nationality
    }
}
