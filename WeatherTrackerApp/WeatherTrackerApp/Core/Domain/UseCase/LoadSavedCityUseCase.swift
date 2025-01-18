//
//  LoadSavedCityUseCase.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation

protocol LoadSavedCityUseCaseProtocol {
    func execute() throws -> WeatherResponse?
}

final class LoadSavedCityUseCase: LoadSavedCityUseCaseProtocol {
    private let cityRepository: CityRepository

    init(cityRepository: CityRepository = CityRepositoryImpl()) {
        self.cityRepository = cityRepository
    }

    func execute() -> WeatherResponse? {
        do {
            guard let savedCity = try cityRepository.fetchSavedCity() else { return nil }

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
            print("Error loading saved city: \(error.localizedDescription)")
            return nil
        }
    }
}
