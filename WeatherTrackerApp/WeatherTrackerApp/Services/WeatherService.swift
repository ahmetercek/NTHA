//
//  WeatherService.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation

protocol WeatherService {
    func fetchWeather(for city: String) async throws -> WeatherResponse
}

final class WeatherServiceImpl: WeatherService {
    private let apiKey: String
    private let baseURL: String
    private let networkClient: NetworkClientProtocol

    /// Initializer for dependency injection
    init(apiKey: String = "624babbcc88b4085ba051120251801",
         baseURL: String = "https://api.weatherapi.com/v1/current.json",
         networkClient: NetworkClientProtocol = NetworkClient.shared) {
        self.apiKey = apiKey
        self.baseURL = baseURL
        self.networkClient = networkClient
    }

    func fetchWeather(for city: String) async throws -> WeatherResponse {
        guard !city.isEmpty else {
            throw NetworkError.custom(message: "City name cannot be empty.")
        }

        guard let url = URL(string: "\(baseURL)?key=\(apiKey)&q=\(city)") else {
            throw NetworkError.invalidURL
        }

        return try await networkClient.request(
            url: url,
            method: .GET,
            headers: ["Content-Type": "application/json"],
            body: nil,
            responseType: WeatherResponse.self
        )
    }
}
