//
//  SearchCityUseCase.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation

protocol SearchCityUseCaseProtocol {
    func execute(query: String) async throws -> WeatherResponse
}

final class SearchCityUseCase: SearchCityUseCaseProtocol {
    private let repository: WeatherRepository

    init(repository: WeatherRepository = WeatherRepositoryImpl()) {
        self.repository = repository
    }

    func execute(query: String) async throws -> WeatherResponse {
        guard !query.isEmpty else {
            throw SearchCityError.emptyQuery
        }
        return try await repository.getWeather(for: query)
    }

    enum SearchCityError: Error {
        case emptyQuery
    }
}
