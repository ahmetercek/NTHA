//
//  SaveCityUseCase.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation


protocol SaveCityUseCaseProtocol {
    func execute(city: WeatherResponse) throws
}

final class SaveCityUseCase: SaveCityUseCaseProtocol {
    private let cityRepository: CityRepository

    init(cityRepository: CityRepository = CityRepositoryImpl()) {
        self.cityRepository = cityRepository
    }

    func execute(city: WeatherResponse) {
        do {
            try cityRepository.replaceCity(with: city)
        } catch {
            print("Error saving city: \(error.localizedDescription)")
        }
    }
}
