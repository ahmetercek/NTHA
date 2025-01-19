//
//  WeatherTrackerAppTests.swift
//  WeatherTrackerAppTests
//
//  Created by Ahmet on 18.01.2025.
//

import XCTest
@testable import WeatherTrackerApp

final class WeatherTrackerAppTests: XCTestCase {
    private var mockNetworkClient: MockNetworkClient!
    private var weatherService: WeatherServiceImpl!

    // MARK: - Setup and Teardown

    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        weatherService = WeatherServiceImpl(networkClient: mockNetworkClient)
    }

    override func tearDown() {
        mockNetworkClient = nil
        weatherService = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testFetchWeatherSuccess() async throws {
        // Arrange
        let mockResponse = WeatherResponse(
            location: Location(name: "London", region: "England", country: "UK"),
            current: CurrentWeather(
                tempC: 20.0,
                condition: Condition(text: "Sunny", icon: "//cdn.weatherapi.com/icon.png"),
                humidity: 60,
                uv: 5.0,
                feelslikeC: 22.0
            )
        )
        mockNetworkClient.result = .success(mockResponse)

        // Act
        let weather = try await weatherService.fetchWeather(for: "London")

        // Assert
        XCTAssertEqual(weather.location.name, "London")
        XCTAssertEqual(weather.current.tempC, 20.0)
        XCTAssertEqual(weather.current.condition.text, "Sunny")
    }

    func testFetchWeatherFailure() async {
        // Arrange
        mockNetworkClient.result = .failure(NetworkError.custom(message: "Network error occurred"))

        // Act & Assert
        do {
            _ = try await weatherService.fetchWeather(for: "London")
            XCTFail("Expected an error, but no error was thrown.")
        } catch {
            guard let networkError = error as? NetworkError else {
                XCTFail("Unexpected error type: \(error)")
                return
            }
            XCTAssertEqual(networkError.localizedDescription, "Network error occurred")
        }
    }
}
