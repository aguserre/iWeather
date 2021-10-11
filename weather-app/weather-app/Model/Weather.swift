//
//  Weather.swift
//  weather-app
//
//  Created by Agustin Errecalde on 05/10/2021.
//

struct WeatherModel {
    let coord: Coordinates
    let weather: [Weather]
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
        ["2643743", "3441575", "3433955"]
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
        self.weather = try container.decode([Weather].self, forKey: .weather)
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

struct Coordinates {
    let lon: Double
    let lat: Double
}
extension Coordinates: Codable {
    enum CodingKeys: String, CodingKey {
        case lon
        case lat
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.lon = try container.decode(Double.self, forKey: .lon)
        self.lat = try container.decode(Double.self, forKey: .lat)
    }
}

struct Weather {
    let id: Int
    let main: MainValues
    let description: String
    let icon: String
}

extension Weather: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.main = try container.decode(MainValues.self, forKey: .main)
        self.description = try container.decode(String.self, forKey: .description)
        self.icon = try container.decode(String.self, forKey: .icon)
    }
}

enum MainValues: String {
    case Rain = "Rain"
    case Thunderstorm = "Thunderstorm"
    case Drizzle = "Drizzle"
    case Snow = "Snow"
    case Fog = "Fog"
    case Smoke = "Smoke"
    case Mist = "Mist"
    case Clear = "Clear"
    case Clouds = "Clouds"
    case unknown
}
extension MainValues: Codable {
    public init(from decoder: Decoder) throws {
        self = try MainValues(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}

struct MainData {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

extension MainData: Codable {
    enum CodingKeys: String, CodingKey {
        case temp
        case feels_like
        case temp_min
        case temp_max
        case pressure
        case humidity
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.feels_like = try container.decode(Double.self, forKey: .feels_like)
        self.temp_min = try container.decode(Double.self, forKey: .temp_min)
        self.temp_max = try container.decode(Double.self, forKey: .temp_max)
        self.pressure = try container.decode(Int.self, forKey: .pressure)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
    }
}

struct Wind {
    let speed: Double
    let deg: Int
}
extension Wind: Codable {
    enum CodingKeys: String, CodingKey {
        case speed
        case deg
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.speed = try container.decode(Double.self, forKey: .speed)
        self.deg = try container.decode(Int.self, forKey: .deg)
    }
}

struct Clouds {
    let all: Int
}
extension Clouds: Codable {
    enum CodingKeys: String, CodingKey {
        case all
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.all = try container.decode(Int.self, forKey: .all)
    }
}
struct Sys {
    let country: String
    let sunrise: Int
    let sunset: Int
}

extension Sys: Codable {
    enum CodingKeys: String, CodingKey {
        case country
        case sunrise
        case sunset
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.country = try container.decode(String.self, forKey: .country)
        self.sunrise = try container.decode(Int.self, forKey: .sunrise)
        self.sunset = try container.decode(Int.self, forKey: .sunset)
    }
}
