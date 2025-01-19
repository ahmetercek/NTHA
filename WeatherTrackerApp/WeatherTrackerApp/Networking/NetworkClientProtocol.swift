//
//  NetworkClientProtocol.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation

/// Protocol for Network Client
protocol NetworkClientProtocol {
    func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]?,
        body: Data?,
        responseType: T.Type
    ) async throws -> T
}

/// Enum for HTTP Methods
enum HTTPMethod: String {
    case GET, POST, PUT, DELETE, PATCH
}
