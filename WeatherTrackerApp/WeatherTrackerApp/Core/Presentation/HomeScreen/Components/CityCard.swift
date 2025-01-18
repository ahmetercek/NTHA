//
//  CityCard.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import SwiftUI

struct CityCard: View {
    let cityName: String
    let temperature: Double
    let onTap: (() -> Void)?

    var body: some View {
        Button(action: { onTap?() }) {
            HStack {
                Text(cityName)
                    .font(.headline)
                Spacer()
                Text("\(temperature, specifier: "%.1f")°C")
                    .font(.subheadline)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}
