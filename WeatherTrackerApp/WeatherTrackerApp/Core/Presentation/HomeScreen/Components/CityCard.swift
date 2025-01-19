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
    let iconURL: String? // Optional icon URL
    let onTap: (() -> Void)?

    var body: some View {
        Button(action: { onTap?() }) {
            HStack(spacing: 16) {
                // City Info
                VStack(alignment: .leading) {
                    Text(cityName)
                        .font(.custom("Poppins-Medium", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    HStack {
                        Text("\(Int(temperature))")
                            .font(.custom("Poppins-Medium", size: 60))
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Text("°")
                            .font(.custom("Poppins-Medium", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .frame(height: 50, alignment: .top)
                            
                    }
                    
                }

                Spacer()

                // Icon
                if let iconURL = iconURL, let url = URL(string: "https:\(iconURL)") {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 83, height: 67)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 50, height: 50)
                    }
                } else {
                    // Placeholder for missing icon
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 50)
                        .cornerRadius(5)
                }
            }
            .padding()
            .frame(height: 117) // Fixed height
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}
