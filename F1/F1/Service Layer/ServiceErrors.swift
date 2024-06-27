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
    case offlineError
}

enum Method {
    case GET
}
