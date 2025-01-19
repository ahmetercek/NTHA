//
//  WeatherRepository.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation

protocol WeatherRepository {
    func getWeather(for city: String) async throws -> WeatherResponse
}

final class WeatherRepositoryImpl: WeatherRepository {
    private let service: WeatherService

    init(service: WeatherService = WeatherServiceImpl()) {
        self.service = service
    }

    func getWeather(for city: String) async throws -> WeatherResponse {
        return try await service.fetchWeather(for: city)
    }
}
