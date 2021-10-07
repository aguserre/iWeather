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
    
    var isNight: Bool {
        let dayRange = self.sys.sunrise...self.sys.sunset
        return !dayRange.contains(self.dt)
    }
    
    var backGroundColor: String {
        switch self.weather.main {
        case "Clear" :
            return isNight ? "clearNight" : "clear"
        default:
            return isNight ? "cloudyNight" : "cloudyDay"
        }
    }
    
    var currentInHours: Int {
        return dt.convertToHourDay(timeFromGMT: tymezone)
    }
    
    var sunsetInHours: Int {
        return sys.sunset.convertToHourDay(timeFromGMT: tymezone)
    }
    
    var sunriseInHours: Int {
        return sys.sunrise.convertToHourDay(timeFromGMT: tymezone)
    }
    
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

var weatherFakes: [WeatherModel] = [WeatherModel(coord: Coordinates(long: -122.08, lat: 37.39),
                               weather: Weather(id: 2, main: "Clear", description: "Clear Night", icon: "01n"),
                               base: "",
                               main: MainData(temp: 5,
                                              feels_like: 546,
                                              temp_min: 200,
                                              temp_max: 300,
                                              pressure: 1023,
                                              humidity: 100),
                               visibility: 16093,
                               wind: Wind(speed: 1.5,
                                          deg: 2),
                               clouds: Clouds(all: 1),
                               dt: 26000,
                               sys: Sys(type: 1, id: 5122, message: 0.0139, country: "US", sunrise: 10000, sunset: 20000),
                               tymezone: -25200,
                               id: 42000,
                               name: "Mountain View",
                               cod: 200),
                                   
                                   WeatherModel(coord: Coordinates(long: -60.49082007148439, lat: -35.11631263163275),
                                                                  weather: Weather(id: 2, main: "Other", description: "Cloudy Night", icon: "02n"),
                                                                  base: "",
                                                                  main: MainData(temp: 26,
                                                                                 feels_like: 546,
                                                                                 temp_min: 200,
                                                                                 temp_max: 300,
                                                                                 pressure: 1023,
                                                                                 humidity: 100),
                                                                  visibility: 16093,
                                                                  wind: Wind(speed: 1.5,
                                                                             deg: 2),
                                                                  clouds: Clouds(all: 1),
                                                                  dt: 25000,
                                                                  sys: Sys(type: 1, id: 5122, message: 0.0139, country: "US", sunrise: 10000, sunset: 20000),
                                                                  tymezone: -25200,
                                                                  id: 42001,
                                                                  name: "Bragado",
                                                                  cod: 200),
                                    WeatherModel(coord: Coordinates(long: 20, lat: 20),
                                                                   weather: Weather(id: 2, main: "Clear", description: "Clear sky", icon: "01d"),
                                                                   base: "",
                                                                   main: MainData(temp: -10,
                                                                                  feels_like: 546,
                                                                                  temp_min: 200,
                                                                                  temp_max: 300,
                                                                                  pressure: 1023,
                                                                                  humidity: 100),
                                                                   visibility: 16093,
                                                                   wind: Wind(speed: 1.5,
                                                                              deg: 2),
                                                                   clouds: Clouds(all: 1),
                                                                   dt: 18,
                                                                   sys: Sys(type: 1, id: 5122, message: 0.0139, country: "US", sunrise: 6, sunset: 19),
                                                                   tymezone: -25200,
                                                                   id: 42002,
                                                                   name: "London",
                                                                   cod: 200),
                                    WeatherModel(coord: Coordinates(long: 20, lat: 20),
                                                                   weather: Weather(id: 2, main: "Other", description: "Cloudy day", icon: "02d"),
                                                                   base: "",
                                                                   main: MainData(temp: 282.55,
                                                                                  feels_like: 546,
                                                                                  temp_min: 200,
                                                                                  temp_max: 300,
                                                                                  pressure: 1023,
                                                                                  humidity: 100),
                                                                   visibility: 16093,
                                                                   wind: Wind(speed: 1.5,
                                                                              deg: 2),
                                                                   clouds: Clouds(all: 1),
                                                                   dt: 17,
                                                                   sys: Sys(type: 1, id: 5122, message: 0.0139, country: "US", sunrise: 6, sunset: 19),
                                                                   tymezone: -25200,
                                                                   id: 42003,
                                                                   name: "Mechita",
                                                                   cod: 200)]
