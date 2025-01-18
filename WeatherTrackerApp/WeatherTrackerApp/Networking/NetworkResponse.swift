//
//  NetworkResponse.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation

/// Enum for handling HTTP response validation
enum NetworkResponse {
    static func validateResponse(_ response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }

        switch httpResponse.statusCode {
        case 200...299:
            break // Successful response
        case 400...499:
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        case 500...599:
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        default:
            throw NetworkError.unknown
        }
    }
}
