//
//  WeatherResponse.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import Foundation

struct WeatherResponse: Decodable {
   let location: Location
   let current: CurrentWeather
}

struct Location: Decodable {
   let name: String
   let region: String
   let country: String
}

struct CurrentWeather: Decodable {
   let tempC: Double
   let condition: Condition
   let humidity: Int
   let uv: Double
   let feelslikeC: Double
}

struct Condition: Decodable {
   let text: String
   let icon: String
}
