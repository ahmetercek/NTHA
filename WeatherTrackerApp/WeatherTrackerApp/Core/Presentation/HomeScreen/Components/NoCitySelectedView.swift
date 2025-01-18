//
//  NoCitySelectedView.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import SwiftUI

struct NoCitySelectedView: View {
    var body: some View {
        VStack(spacing: 10) {
            // Big Title Label
            Text("No City Selected")
                .font(.title) // Adjust as needed for size
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "2C2C2C"))
            
            // Subtitle Label
            Text("Please Search For A City")
                .font(.subheadline) // Slightly smaller than title
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "2C2C2C"))
        }
    }
}
