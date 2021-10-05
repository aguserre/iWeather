//
//  Weather.swift
//  weather-app
//
//  Created by Agustin Errecalde on 05/10/2021.
//

struct WeatherModel: Codable {
    let coord: Coordinates
    let weather: Weather
    let base: String
    let main: MainData
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let tymezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Coordinates: Codable {
    let long: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainData: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Clouds: Codable {
    let all: Int
}
struct Sys: Codable {
    let type: Int
    let id: Int
    let message: Double
    let country: String
    let sunrise: Int
    let sunset: Int
}

