//
//  MockNetworkClient.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation
@testable import WeatherTrackerApp

final class MockNetworkClient: NetworkClientProtocol {
    // Define a result property to simulate responses
    var result: Result<Any, Error>?

    func request<T>(
        url: URL,
        method: WeatherTrackerApp.HTTPMethod,
        headers: [String: String]?,
        body: Data?,
        responseType: T.Type
    ) async throws -> T where T: Decodable {
        guard let result = result else {
            throw NetworkError.custom(message: "No result set.")
        }

        switch result {
        case .success(let response):
            // Attempt to cast the response to the expected type
            guard let castResponse = response as? T else {
                throw NetworkError.custom(message: "Invalid Response Type")
            }
            return castResponse
        case .failure(let error):
            throw error
        }
    }
}
