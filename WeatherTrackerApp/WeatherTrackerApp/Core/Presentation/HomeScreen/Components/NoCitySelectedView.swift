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
                .font(.custom("Poppins-Bold", size: 30))
                .foregroundColor(.primary)
                .foregroundColor(Color(hex: "2C2C2C"))
            
            // Subtitle Label
            Text("Please Search For A City")
                .font(.custom("Poppins-Bold", size: 15))
                .foregroundColor(Color(hex: "2C2C2C"))
        }
    }
}
