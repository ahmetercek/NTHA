# NTHA

# **Weather Tracker App**

The Weather Tracker App is an iOS application built with **SwiftUI** and follows **Clean Architecture** principles. It enables users to search for cities, view current weather details, and save a preferred city for quick access.

---

## **Features**

- **City Search**: Search for cities to fetch weather data.
- **Weather Details**:
  - Temperature, Condition (with icon), Humidity, UV Index, and Feels Like Temperature.
- **Save City**: Save a city for quick access to weather details.
- **Local Persistence**: Data is stored locally using Core Data.
- **Fresh Data Preference**:
  - On app launch, the app tries to fetch fresh weather data from the API.
  - If the API request fails, it gracefully falls back to data stored in Core Data.

---

## **Tech Stack**

- **Language**: Swift 5+
- **Frameworks**: SwiftUI, Core Data
- **Architecture**: Clean Architecture (MVVM)
- **Networking**: Custom NetworkClient using `async/await`
- **Testing**: XCTest with Mock Dependencies

---