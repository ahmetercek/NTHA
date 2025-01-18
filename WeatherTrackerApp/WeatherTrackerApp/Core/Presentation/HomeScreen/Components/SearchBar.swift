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
                .padding(10)
                .background(Color(hex: "F2F2F2"))
                .cornerRadius(15)

            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.trailing, 10)
        }
        .background(Color(hex: "F2F2F2"))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}
