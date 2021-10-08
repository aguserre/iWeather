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
    var currentInHours: Int {
        return dt.convertToHourDay(timeFromGMT: timezone)
    }
    var sunsetInHours: Int {
        return sys.sunset.convertToHourDay(timeFromGMT: timezone)
    }
    var sunriseInHours: Int {
        return sys.sunrise.convertToHourDay(timeFromGMT: timezone)
    }
    
    static var placeHolder: WeatherModel {
        return WeatherModel(coord: Coordinates(lon: -60.49082007148439,
                                               lat: -35.11631263163275),
                            weather: [Weather(id: 2,
                                              main: .Rain,
                                              description: "Cloudy Night",
                                              icon: "02n")],
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
                            sys: Sys(type: 1,
                                     id: 5122,
                                     country: "US",
                                     sunrise: 10000,
                                     sunset: 20000),
                            timezone: -25200,
                            id: 42001,
                            name: "Bragado",
                            cod: 200)
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

enum MainValues: String, Codable {
    case Rain = "Rain"
    case Thunderstorm = "Thunderstorm"
    case Drizzle = "Drizzle"
    case Snow = "Snow"
    case Atmosphere = "Atmosphere"
    case Clear = "Clear"
    case Clouds = "Clouds"
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
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}

extension Sys: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case id
        case country
        case sunrise
        case sunset
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(Int.self, forKey: .type)
        self.id = try container.decode(Int.self, forKey: .id)
        self.country = try container.decode(String.self, forKey: .country)
        self.sunrise = try container.decode(Int.self, forKey: .sunrise)
        self.sunset = try container.decode(Int.self, forKey: .sunset)
    }
}
