//
//  LoadSavedCityUseCase.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation

protocol LoadSavedCityUseCaseProtocol {
    func execute() async throws -> WeatherResponse?
}

final class LoadSavedCityUseCase: LoadSavedCityUseCaseProtocol {
    private let cityRepository: CityRepository

    init(cityRepository: CityRepository = CityRepositoryImpl()) {
        self.cityRepository = cityRepository
    }

    func execute() async throws -> WeatherResponse? {
        do {
            // Attempt to fetch saved city data
            guard let savedCity = try await cityRepository.fetchSavedCity() else { return nil }

            // Map the saved city to WeatherResponse
            return WeatherResponse(
                location: Location(name: savedCity.name ?? "", region: "", country: ""),
                current: CurrentWeather(
                    tempC: savedCity.temperature,
                    condition: Condition(text: savedCity.condition ?? "", icon: savedCity.icon ?? ""),
                    humidity: Int(savedCity.humidity),
                    uv: savedCity.uvIndex,
                    feelslikeC: savedCity.feelsLike
                )
            )
        } catch {
            // Propagate the error to be handled by the caller
            throw LoadSavedCityError.failedToLoadSavedCity(error.localizedDescription)
        }
    }
}

// MARK: - LoadSavedCityError

enum LoadSavedCityError: Error {
    case failedToLoadSavedCity(String)

    var localizedDescription: String {
        switch self {
        case .failedToLoadSavedCity(let message):
            return "Failed to load saved city: \(message)"
        }
    }
}
