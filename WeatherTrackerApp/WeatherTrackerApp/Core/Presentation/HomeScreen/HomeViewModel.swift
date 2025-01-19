//
//  HomeViewModel.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation

enum SearchState {
    case idle
    case loading
    case success([WeatherResponse])
    case error(String)
}

enum LoadingState {
    case idle
    case loading
    case success(WeatherResponse)
    case error(String)
}

final class HomeViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published private(set) var weather: WeatherResponse?
    @Published private(set) var searchResults: [WeatherResponse] = []
    @Published var searchState: SearchState = .idle
    @Published var savedCityState: LoadingState = .idle

    private let searchCityUseCase: SearchCityUseCaseProtocol
    private let saveCityUseCase: SaveCityUseCaseProtocol
    private let loadSavedCityUseCase: LoadSavedCityUseCaseProtocol
    private var searchTask: Task<Void, Never>?

    init(searchCityUseCase: SearchCityUseCaseProtocol,
         saveCityUseCase: SaveCityUseCaseProtocol,
         loadSavedCityUseCase: LoadSavedCityUseCaseProtocol) {
        self.searchCityUseCase = searchCityUseCase
        self.saveCityUseCase = saveCityUseCase
        self.loadSavedCityUseCase = loadSavedCityUseCase

        loadSavedCity()
    }

    // MARK: - Search Logic

    func searchCity(_ query: String) {
        guard !query.isEmpty else {
            resetSearchResults()
            return
        }

        searchState = .loading
        searchTask?.cancel()

        searchTask = Task {
            do {
                let results = try await searchCityUseCase.execute(query: query)
                guard !Task.isCancelled else { return }
                await updateSearchResults(with: [results])
            } catch {
                if Task.isCancelled { return }
                await handleSearchError(for: query, error: error)
            }
        }
    }

    private func resetSearchResults() {
        searchResults = []
        searchState = .idle
    }

    @MainActor
    private func updateSearchResults(with results: [WeatherResponse]) {
        searchResults = results
        searchState = .success(results)
    }

    @MainActor
    private func handleSearchError(for query: String, error: Error) {
        // Search Not Found Logic
    }

    // MARK: - Save City Logic

    func saveCity(_ city: WeatherResponse) {
        do {
            try saveCityUseCase.execute(city: city)
            loadSavedCity()
        } catch {
            handleError("Failed to save city", error: error)
        }
    }

    // MARK: - Load Saved City Logic

    func loadSavedCity() {
        savedCityState = .loading

        Task {
            do {
                if let savedCity = try await loadSavedCityUseCase.execute() {
                    await MainActor.run {
                        weather = savedCity
                        savedCityState = .success(savedCity)
                    }
                } else {
                    await MainActor.run {
                        savedCityState = .idle
                    }
                }
            } catch {
                await MainActor.run {
                    savedCityState = .error("Failed to load saved city: \(error.localizedDescription)")
                }
                handleError("Failed to load saved city", error: error)
            }
        }
    }

    // MARK: - Error Handling

    private func handleError(_ message: String, error: Error) {
        print("\(message): \(error.localizedDescription)")
    }
}
