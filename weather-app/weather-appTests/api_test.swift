//
//  api_test.swift
//  weather-appTests
//
//  Created by Agustin Errecalde on 12/10/2021.
//

import XCTest
@testable import weather_app

final class api_test: XCTestCase {
    var weatherProvider: WeatherProvider!
    var mockApiClient: MockApiClient!

    override func setUp() {
        mockApiClient = MockApiClient()
        weatherProvider = WeatherProvider(apiClient: mockApiClient)
    }

    func test_allWeathersWithIdReturnsResponse() {
        let expectedResponse = WeatherModelFake().fakeWeather
        let expectation = XCTestExpectation(description: "weathers")

        _ = weatherProvider.allWeathersById(id: "")
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertEqual(response, expectedResponse)
                expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func test_allWeathersWithCoordinatesReturnsResponse() {
        let expectedResponse = WeatherModelFake().fakeWeather
        let expectation = XCTestExpectation(description: "weathers")

        _ = weatherProvider.allWeathersByCoords(lon: 0, lat: 0)
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertEqual(response, expectedResponse)
                expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
}
