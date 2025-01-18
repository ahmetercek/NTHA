//
//  GetWeatherUseCase.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation

protocol GetWeatherUseCase {
    func execute(for city: String) async throws -> WeatherResponse
}

final class GetWeatherUseCaseImpl: GetWeatherUseCase {
    private let repository: WeatherRepository

    init(repository: WeatherRepository = WeatherRepositoryImpl()) {
        self.repository = repository
    }

    func execute(for city: String) async throws -> WeatherResponse {
        return try await repository.getWeather(for: city)
    }
}
