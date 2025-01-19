//
//  NetworkClient.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation

/// Concrete implementation of the Network Client
final class NetworkClient: NetworkClientProtocol {
    static let shared = NetworkClient() // Singleton instance
    private init() {}

    /// Generic request method
    func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: Data? = nil,
        responseType: T.Type
    ) async throws -> T {
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body

        // Add headers
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        // Perform the network request
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            // Validate the response
            try NetworkResponse.validateResponse(response)

            // Decode the response
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch let error as NetworkError {
            throw error
        } catch let decodingError as DecodingError {
            throw NetworkError.decodingError
        } catch {
            throw NetworkError.unknown
        }
    }
}
