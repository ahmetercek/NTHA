//
//  NetworkError.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation

/// Enum for Network Errors
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case custom(message: String)
    case unknown
}

/// Extension for custom error messages
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .noData:
            return "No data was returned by the server."
        case .decodingError:
            return "Failed to decode the response."
        case .serverError(let statusCode):
            return "Server returned an error with status code \(statusCode)."
        case .custom(let message):
            return message
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
