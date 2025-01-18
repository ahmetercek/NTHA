//
//  HomeViewModel.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var searchResults: [WeatherResponse] = []
    @Published var errorMessage: String?
    
    private let getWeatherUseCase: GetWeatherUseCase
    private var searchTask: Task<Void, Never>?
    
    init(getWeatherUseCase: GetWeatherUseCase = GetWeatherUseCaseImpl()) {
        self.getWeatherUseCase = getWeatherUseCase
    }
    
    func searchCity(_ query: String) {
        guard !query.isEmpty else {
            searchResults = []
            return
        }

        // Cancel any ongoing search
        searchTask?.cancel()

        // Run the API call on a background thread
        searchTask = Task {
            do {
                let result = try await Task.detached(priority: .background) {
                    try await self.getWeatherUseCase.execute(for: query)
                }.value

                // Update UI on the main thread
                await MainActor.run {
                    self.searchResults = [result]
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "No results found for \"\(query)\"."
                    self.searchResults = []
                }
            }
        }
    }
}
