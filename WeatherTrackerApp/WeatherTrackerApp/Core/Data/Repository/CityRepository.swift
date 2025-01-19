//
//  CityRepository.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation
import CoreData

protocol CityRepository {
    func saveCity(_ city: WeatherResponse) throws
    func fetchSavedCity() async throws -> SavedCity?
    func replaceCity(with city: WeatherResponse) throws
}

final class CityRepositoryImpl: CityRepository {
    private let context: NSManagedObjectContext
    private let weatherService: WeatherService

    init(context: NSManagedObjectContext = CoreDataManager.shared.context,
         weatherService: WeatherService = WeatherServiceImpl()) {
        self.context = context
        self.weatherService = weatherService
    }

    func saveCity(_ city: WeatherResponse) throws {
        let savedCity = SavedCity(context: context)
        savedCity.id = UUID()
        savedCity.name = city.location.name
        savedCity.temperature = city.current.tempC
        savedCity.condition = city.current.condition.text
        savedCity.icon = city.current.condition.icon
        savedCity.humidity = Int16(city.current.humidity)
        savedCity.uvIndex = city.current.uv
        savedCity.feelsLike = city.current.feelslikeC

        try saveContext()
    }

    func fetchSavedCity() async throws -> SavedCity? {
        if let localCity = try? fetchLocalCity() {
            do {
                // Fetch fresh data from WeatherService
                let freshWeather = try await weatherService.fetchWeather(for: localCity.name ?? "")
                try replaceCity(with: freshWeather) // Save fresh data locally
                return try fetchLocalCity() // Return updated local city
            } catch {
                // If fetching fresh data fails, return local city
                print("Failed to fetch fresh data. Returning local data. Error: \(error.localizedDescription)")
                return localCity
            }
        }

        // No local data available
        return nil
    }

    func replaceCity(with city: WeatherResponse) throws {
        // Delete the existing city
        if let existingCity = try fetchLocalCity() {
            context.delete(existingCity)
        }

        // Save the new city
        try saveCity(city)
    }

    // MARK: - Private Helper Methods

    private func fetchLocalCity() throws -> SavedCity? {
        let fetchRequest: NSFetchRequest<SavedCity> = SavedCity.fetchRequest()

        do {
            return try context.fetch(fetchRequest).first
        } catch {
            throw CoreDataError.fetchFailed("Failed to fetch saved city: \(error.localizedDescription)")
        }
    }

    private func saveContext() throws {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw CoreDataError.saveFailed("Failed to save changes to context: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - CoreDataError Enum

enum CoreDataError: Error {
    case fetchFailed(String)
    case saveFailed(String)

    var localizedDescription: String {
        switch self {
        case .fetchFailed(let message), .saveFailed(let message):
            return message
        }
    }
}
