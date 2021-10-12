//
//  Weather.swift
//  weather-app
//
//  Created by Agustin Errecalde on 05/10/2021.
//

struct WeatherModel: Equatable {
    static func == (lhs: WeatherModel, rhs: WeatherModel) -> Bool {
        lhs.id == rhs.id
    }
    
    let coord: Coordinates
    let weather: [MainWeather]
    let base: String
    let main: MainData
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    var isCurrent: Bool?
    
    var isNight: Bool {
        let dayRange = self.sys.sunrise...self.sys.sunset
        return !dayRange.contains(self.dt)
    }
    var backGroundColor: String {
        switch self.weather.first?.main {
        case .Clear :
            return isNight ? "clearNight" : "clear"
        default:
            return isNight ? "cloudyNight" : "cloudyDay"
        }
    }
    var currentTime: String {
        return dt.convertToCurrentTime(timeFromGMT: timezone)
    }
    
    var currentInHours: Int {
        return dt.convertToHourDay(timeFromGMT: timezone)
    }
    var sunsetInHours: Int {
        return sys.sunset.convertToHourDay(timeFromGMT: timezone)
    }
    var sunriseInHours: Int {
        return sys.sunrise.convertToHourDay(timeFromGMT: timezone)
    }
    
    static var placeHolder: WeatherViewModel {
        WeatherViewModel(pageViewModels: [WeatherPageViewModel(weather: lastWeatherSaved)])
    }
    
    static var citySavedIds: [String] {
        AppData.savedIds
    }
    
    static var lastWeatherSaved: WeatherModel {
        AppData.lastCurrentWeather
    }
    
}

extension WeatherModel: Codable {
    enum CodingKeys: String, CodingKey {
        case coord
        case weather
        case base
        case main
        case visibility
        case wind
        case clouds
        case dt
        case sys
        case timezone
        case id
        case name
        case cod
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.coord = try container.decode(Coordinates.self, forKey: .coord)
        self.weather = try container.decode([MainWeather].self, forKey: .weather)
        self.base = try container.decode(String.self, forKey: .base)
        self.main = try container.decode(MainData.self, forKey: .main)
        self.wind = try container.decode(Wind.self, forKey: .wind)
        self.clouds = try container.decode(Clouds.self, forKey: .clouds)
        self.dt = try container.decode(Int.self, forKey: .dt)
        self.sys = try container.decode(Sys.self, forKey: .sys)
        self.timezone = try container.decode(Int.self, forKey: .timezone)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.cod = try container.decode(Int.self, forKey: .cod)
        self.visibility = try container.decode(Int.self, forKey: .visibility)
    }
}
