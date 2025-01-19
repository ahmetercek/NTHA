//
//  SearchBar.swift
//  WeatherTrackerApp
//
//  Created by Ahmet on 18.01.2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(15)
                .background(Color(hex: "F2F2F2"))
                .cornerRadius(15)

            Image("search_icon")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20) // Adjust size as needed
                .padding(.trailing, 20)
        }
        .background(Color(hex: "F2F2F2"))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}
