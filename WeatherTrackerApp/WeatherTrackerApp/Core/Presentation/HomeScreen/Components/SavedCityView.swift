//
//  SavedCityView.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import SwiftUI

struct SavedCityView: View {
    let savedCity: WeatherResponse

    var body: some View {
        VStack(spacing: 16) {
            // Weather Icon
            WeatherIconView(iconURL: savedCity.current.condition.icon)

            // City Information
            CityInfoView(
                cityName: savedCity.location.name,
                temperature: savedCity.current.tempC
            )

            // Weather Details
            WeatherDetailsView(
                humidity: savedCity.current.humidity,
                uvIndex: savedCity.current.uv,
                feelsLike: savedCity.current.feelslikeC
            )
        }
        .padding(.horizontal)
    }
}

// MARK: - Components

struct WeatherIconView: View {
    let iconURL: String

    var body: some View {
        AsyncImage(url: URL(string: "https:\(iconURL)")) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        } placeholder: {
            ProgressView() // Loading spinner while image loads
        }
    }
}

struct CityInfoView: View {
    let cityName: String
    let temperature: Double

    var body: some View {
        VStack(spacing: 8) {
            Text(cityName)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            Text("\(temperature, specifier: "%.1f")°C")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
        }
    }
}

struct WeatherDetailsView: View {
    let humidity: Int
    let uvIndex: Double
    let feelsLike: Double

    var body: some View {
        HStack(spacing: 16) {
            DetailItem(title: "Humidity", value: "\(humidity)%")
            DetailItem(title: "UV Index", value: "\(uvIndex)")
            DetailItem(title: "Feels Like", value: "\(feelsLike)°C")
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct DetailItem: View {
    let title: String
    let value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.headline)
                .foregroundColor(.primary)
        }
    }
}
