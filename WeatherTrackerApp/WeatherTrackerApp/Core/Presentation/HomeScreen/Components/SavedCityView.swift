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
        VStack(spacing: 45) {
            // Weather Icon
            WeatherIconView(iconURL: savedCity.current.condition.icon)
            // City Information
            CityInfoView(
                cityName: savedCity.location.name,
                temperature: savedCity.current.tempC
            ).padding(.bottom, 30)
            // Weather Details
            WeatherDetailsView(
                humidity: savedCity.current.humidity,
                uvIndex: savedCity.current.uv,
                feelsLike: savedCity.current.feelslikeC
            ).padding(15)
            Spacer()
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
                .resizable().aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(height: 123, alignment: .bottom)
        } placeholder: {
            ProgressView() // Loading spinner while image loads
        }
    }
}

struct CityInfoView: View {
    let cityName: String
    let temperature: Double

    var body: some View {
        VStack(spacing: 20) {
            HStack() {
                Text(cityName)
                    .font(.custom("Poppins-Bold", size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Image("city_vector")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 21, height: 21)
            }
            HStack {
                Text("\(Int(temperature))")
                    .font(.custom("Poppins-Medium", size: 70))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Text("°")
                    .font(.custom("Poppins-Medium", size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .frame(height: 80, alignment: .top)
                    
            }
        }.frame(height:75, alignment: .top)
    }
}

struct WeatherDetailsView: View {
    let humidity: Int
    let uvIndex: Double
    let feelsLike: Double

    var body: some View {
        HStack() {
            DetailItem(title: "Humidity", value: "\(humidity)%")
            Spacer()
            DetailItem(title: "UV", value: "\(uvIndex)")
            Spacer()
            DetailItem(title: "Feels Like", value: "\(Int(feelsLike))\u{00B0}")
        }
        .padding(25)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
    }
}

struct DetailItem: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.custom("Poppins-Medium", size: 12))
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "C4C4C4"))
            Text(value)
                .font(.custom("Poppins-Medium", size: 15))
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "9A9A9A"))
        }
    }
}
