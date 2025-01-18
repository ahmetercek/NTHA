//
//  HomeView.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            // Search Results
            Spacer()
            Button("Test") {
                viewModel.searchCity("Paris")
            }
            Spacer()
        }
    }
}
