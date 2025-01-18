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
    func fetchSavedCity() throws -> SavedCity?
    func replaceCity(with city: WeatherResponse) throws
}

final class CityRepositoryImpl: CityRepository {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataManager.shared.context) {
        self.context = context
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

    func fetchSavedCity() throws -> SavedCity? {
        let fetchRequest: NSFetchRequest<SavedCity> = SavedCity.fetchRequest()

        do {
            return try context.fetch(fetchRequest).first
        } catch {
            throw CoreDataError.fetchFailed("Failed to fetch saved city: \(error.localizedDescription)")
        }
    }

    func replaceCity(with city: WeatherResponse) throws {
        // Delete the existing city
        if let existingCity = try fetchSavedCity() {
            context.delete(existingCity)
        }

        // Save the new city
        try saveCity(city)
    }

    // MARK: - Private Helper Methods

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
