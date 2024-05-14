//
//  ServiceErrors.swift
//  F1
//
//
//

import Foundation

enum APIError: String, Error {
    case internalError
    case serverError
    case parsingError
}

enum Method {
    case GET
}
