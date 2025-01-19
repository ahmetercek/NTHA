//
//  HomeView.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel = HomeViewModel(
        searchCityUseCase: SearchCityUseCase(),
        saveCityUseCase: SaveCityUseCase(),
        loadSavedCityUseCase: LoadSavedCityUseCase()
    )) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 16) {
            // Search Bar
            SearchBarView()
                .padding(.top, 22)  // Top padding
            
            // Main Content
            mainContent
            Spacer()
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.top, 22)
        .onAppear {
            viewModel.loadSavedCity()
        }
    }

    // MARK: - Components

    @ViewBuilder
    private func SearchBarView() -> some View {
        SearchBar(text: $viewModel.cityName, placeholder: "Search Location")
            .onChange(of: viewModel.cityName) { newValue in
                viewModel.searchCity(newValue)
            }
    }

    @ViewBuilder
    private var mainContent: some View {
        switch viewModel.searchState {
        case .idle:
            savedCityContent
        case .loading:
            ProgressView("Searching...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .success(let results):
            SearchResultsView(results: results) { city in
                            viewModel.saveCity(city) // Save city action
            }
        case .error(let message):
            ErrorView(message: message)
        }
    }

    @ViewBuilder
    private var savedCityContent: some View {
        switch viewModel.savedCityState {
        case .idle:
            //EmptyView() // Use an empty view for idle state
            Spacer()
            NoCitySelectedView()
            Spacer()
        case .loading:
            ProgressView("Loading saved city...")
        case .success(let savedCity):
            SavedCityView(savedCity: savedCity)
        case .error(let message):
            ErrorView(message: message)
        }
    }
    
    struct SearchResultsView: View {
        let results: [WeatherResponse]
        let onCityTap: (WeatherResponse) -> Void

        var body: some View {
            ScrollView {
                LazyVStack {
                    ForEach(results, id: \.location.name) { city in
                        CityCard(cityName: city.location.name,
                                 temperature: city.current.tempC,
                                 iconURL: city.current.condition.icon) {
                            onCityTap(city) // Save action passed from HomeView
                        }
                    }
                }
            }
        }
    }
    
    struct ErrorView: View {
        let message: String

        var body: some View {
            VStack {
                Text("Error")
                    .font(.title)
                    .foregroundColor(.red)
                Text(message)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
